import 'package:czydobrze/textbook/textbook.dart';
import 'package:czydobrze/explore/textbook_pagination_controller.dart';
import 'package:czydobrze/textbook/textbook_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController =
        watch(TextbookPaginationControllerProvider.notifier);
    final paginationState = watch(TextbookPaginationControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text('Explore'),
      ),
      body: Builder(
        builder: (context) {
          if (paginationState.refreshError) {
            return const Center(child: Text('Something went wrong X('));
          } else if (paginationState.textbooks.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () {
              return context
                  .refresh(TextbookPaginationControllerProvider)
                  .getTextbooks();
            },
            child: ListView.builder(
              itemCount: paginationState.textbooks.length,
              itemBuilder: (context, index) {
                paginationController.handleScrollWithIndex(index);
                return _TextbookTile(
                    textbook: paginationState.textbooks[index]);
              },
            ),
          );
        },
      ),
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
