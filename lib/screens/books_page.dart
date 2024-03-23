import 'package:flutter/material.dart';

import '../widgets/book_card.dart';

class BooksPage extends StatelessWidget {
  final List jsonData;
  const BooksPage({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
            child: Wrap(
              children: jsonData.map((book) {
                return BookCard(
                  id: book['id'],
                  title: book['name'],
                  author: book['author'],
                  cover: book['cover'],
                  description: book['description'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
