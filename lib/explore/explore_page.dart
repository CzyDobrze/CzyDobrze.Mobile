import 'package:czydobrze/explore/course_pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExplorePage extends ConsumerWidget {
  const ExplorePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final paginationController = watch(CoursePaginationControllerProvider.notifier);
    final paginationState = watch(CoursePaginationControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text('Explore'),
      ),

      body: Builder(
        builder: (context) {
          if(paginationState.refreshError) {
            return Center(child: Text(paginationState.errorMessage),);
          } else if(paginationState.courses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () {
              return context.refresh(CoursePaginationControllerProvider).getCourses();
            },
            child: ListView.builder(
              itemCount: paginationState.courses.length,
              itemBuilder: (context, index) {
                paginationController.handleScrollWithIndex(index);
                return ListTile(title: Text(paginationState.courses[index].name),);
              },
            ),
          );
        },
      ),
    );
  }
}