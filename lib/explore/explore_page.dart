import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.search),
        title: const Text('Explore'),
      ),
    );
  }
}