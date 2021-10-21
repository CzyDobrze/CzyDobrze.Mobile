import 'package:czydobrze/comment/comment.dart';
import 'package:czydobrze/excersise/excersise.dart';
import 'package:czydobrze/services/api_service.dart';
import 'package:flutter/material.dart';

class ExcersisePage extends StatelessWidget {
  final Excersise excersise;

  const ExcersisePage(this.excersise, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(excersise.inBookId),
      ),
      body: ListView(
        children: [
          _ExcersiseTile(excersise),
          FutureBuilder<List<Comment>>(
              future: ApiService().getComments(excersise),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Something went wrong with loading comments :/')
                    ],
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  children: snapshot.data!
                      .map<Widget>((comment) => _CommentTile(comment))
                      .toList(),
                );
              })
        ],
      ),
    );
  }
}

class _ExcersiseTile extends StatelessWidget {
  final Excersise excersise;

  const _ExcersiseTile(this.excersise, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(excersise.description),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final Comment comment;

  const _CommentTile(this.comment, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(comment.author.displayName)],
          ),
          Text(comment.content),
        ],
      ),
    );
  }
}
