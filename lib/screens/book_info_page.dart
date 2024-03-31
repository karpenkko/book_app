import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String cover;
  final String description;

  const BookDetailPage({
    super.key,
    required this.title,
    required this.author,
    required this.cover,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: 'cover_$cover',
                child: Image.asset(
                  cover,
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                author,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 14, height: 1.4, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
