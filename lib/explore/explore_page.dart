import 'package:czydobrze/helpers/search_bar.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:czydobrze/textbook/textbook_pagination_controller.dart';
import 'package:czydobrze/textbook/textbook_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      title: 'Odkrywaj',
      builder: (context, query) => _ResultsListView(query: query),
    );
  }
}

class _ResultsListView extends ConsumerWidget {
  final String? query;
  const _ResultsListView({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController =
        watch(textbookPaginationControllerProvider(query).notifier);
    final paginationState = watch(textbookPaginationControllerProvider(query));

    return Builder(
      builder: (context) {
        if (paginationState.refreshError) {
          return const Center(child: Text('Coś poszło nie tak X('));
        } else if (paginationState.textbooks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () {
            return context
                .refresh(textbookPaginationControllerProvider(query))
                .getTextbooks();
          },
          child: ListView.builder(
            itemCount: paginationState.textbooks.length,
            itemBuilder: (context, index) {
              paginationController.handleScrollWithIndex(index);
              return _TextbookTile(
                key: ValueKey(paginationState.textbooks[index]),
                textbook: paginationState.textbooks[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _TextbookTile extends StatelessWidget {
  final Textbook textbook;

  const _TextbookTile({Key? key, required this.textbook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(textbook.subject),
      title: Text(textbook.title),
      subtitle: Text(textbook.publisher),
      trailing: Text(textbook.classYear.toString()),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TextbookPage(textbook))),
    );
  }
}
