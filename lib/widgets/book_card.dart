import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorite_books.dart';
import '../screens/book_info_page.dart';

class BookCard extends StatelessWidget {
  final int id;
  final String title;
  final String author;
  final String cover;
  final String description;

  const BookCard({
    super.key,
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              title: title,
              author: author,
              cover: cover,
              description: description,
            ),
          ),
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - (16 * 3)) / 2,
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
              child: Stack(
                alignment: Alignment.bottomRight, // Для розміщення іконки сердечка у верхньому правому куті
                children: [
                  AspectRatio(
                    aspectRatio: 0.66,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        tag: 'cover_$cover',
                        child: Image.asset(
                          cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Consumer<FavoriteBooksModel>(
                        builder: (context, favoriteBooksModel, child) {
                          final isFavorite = favoriteBooksModel.favoriteBookIds.contains('$id');
                          return Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          );
                        },
                      ),
                      onPressed: () {
                        final favoriteBooksModel = Provider.of<FavoriteBooksModel>(context, listen: false);
                        favoriteBooksModel.toggleFavorite('$id');
                        print(favoriteBooksModel.favoriteBookIds);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                height: 1.1,
                // backgroundColor: Colors.limeAccent,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              author,
              textAlign: TextAlign.center,
              style: const TextStyle(
                // fontStyle: FontStyle.italic,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}