import 'package:czydobrze/excersise/excersise.dart';
import 'package:czydobrze/excersise/excersise_page.dart';
import 'package:czydobrze/excersise/excersise_pagination_controller.dart';
import 'package:czydobrze/section/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SectionPage extends StatelessWidget {
  final Section section;

  const SectionPage(this.section, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sekcja: ${section.title}'),
      ),
      body: _ResultsListView(
        section: section,
      ),
    );
  }
}

class _ResultsListView extends ConsumerWidget {
  final Section section;
  const _ResultsListView({Key? key, required this.section}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController =
        watch(excersisePaginationControllerProvider(section).notifier);
    final paginationState =
        watch(excersisePaginationControllerProvider(section));

    return Builder(
      builder: (context) {
        if (paginationState.refreshError) {
          return const Center(child: Text('Coś poszło nie tak X('));
        } else if (paginationState.excersises.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () {
            return context
                .refresh(excersisePaginationControllerProvider(section))
                .getExcersises();
          },
          child: ListView.builder(
            itemCount: paginationState.excersises.length,
            itemBuilder: (context, index) {
              paginationController.handleScrollWithIndex(index);
              return _ExcersiseTile(
                key: ValueKey(paginationState.excersises[index]),
                excersise: paginationState.excersises[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _ExcersiseTile extends StatelessWidget {
  final Excersise excersise;

  const _ExcersiseTile({Key? key, required this.excersise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(excersise.title),
      title: Text(
        excersise.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ExcersisePage(excersise),
      )),
    );
  }
}
