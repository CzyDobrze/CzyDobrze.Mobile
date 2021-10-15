import 'package:czydobrze/textbook/textbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextbookPage extends ConsumerWidget {
  final Textbook textbook;

  const TextbookPage({ Key? key, required this.textbook }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text(textbook.title),),
    );
  }
}