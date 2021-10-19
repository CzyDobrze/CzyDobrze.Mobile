import 'package:czydobrze/helper_widgets/search_bar.dart';
import 'package:czydobrze/section/section.dart';
import 'package:czydobrze/section/section_page.dart';
import 'package:czydobrze/section/section_pagination_controller.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextbookPage extends StatelessWidget {
  final Textbook textbook;

  const TextbookPage(this.textbook, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      title: textbook.title,
      builder: (context, query) => _ResultsListView(
        textbook: textbook,
      ),
    );
  }
}

class _ResultsListView extends ConsumerWidget {
  final Textbook textbook;
  const _ResultsListView({Key? key, required this.textbook}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController =
        watch(sectionPaginationControllerProvider(textbook).notifier);
    final paginationState =
        watch(sectionPaginationControllerProvider(textbook));

    return Builder(
      builder: (context) {
        if (paginationState.refreshError) {
          return const Center(child: Text('Something went wrong X('));
        } else if (paginationState.sections.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () {
            return context
                .refresh(sectionPaginationControllerProvider(textbook))
                .getSections();
          },
          child: ListView.builder(
            itemCount: paginationState.sections.length,
            itemBuilder: (context, index) {
              paginationController.handleScrollWithIndex(index);
              return _SectionTile(
                key: ValueKey(paginationState.sections[index]),
                section: paginationState.sections[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _SectionTile extends StatelessWidget {
  final Section section;

  const _SectionTile({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(section.title),
      subtitle: Text(section.description),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SectionPage(section),
      )),
    );
  }
}
