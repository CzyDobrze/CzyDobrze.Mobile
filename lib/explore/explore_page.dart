import 'package:czydobrze/helper_widgets/search_bar.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:czydobrze/explore/textbook_pagination_controller.dart';
import 'package:czydobrze/textbook/textbook_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      title: 'Explore',
      builder: (context, query) => ResultsListView(query: query),
    );
  }
}

class ResultsListView extends ConsumerWidget {
  final String? query;
  const ResultsListView({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController =
        watch(TextbookPaginationControllerProvider(query).notifier);
    final paginationState = watch(TextbookPaginationControllerProvider(query));

    return Builder(
      builder: (context) {
        if (paginationState.refreshError) {
          return const Center(child: Text('Something went wrong X('));
        } else if (paginationState.textbooks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () {
            return context
                .refresh(TextbookPaginationControllerProvider(query))
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
          builder: (context) => TextbookPage(textbook: textbook))),
    );
  }
}
