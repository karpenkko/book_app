import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorite_books.dart';
import '../screens/book_info_page.dart';

class BookCard extends StatefulWidget {
  final int id;
  final String title;
  final String author;
  final String cover;
  final String description;
  final Function updateFavourite;

  const BookCard(
      {super.key,
      required this.id,
      required this.title,
      required this.author,
      required this.cover,
      required this.description,
      required this.updateFavourite});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(
              title: widget.title,
              author: widget.author,
              cover: widget.cover,
              description: widget.description,
            ),
          ),
        );
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - (16 * 3)) / 2,
        margin: const EdgeInsets.only(left: 6, right: 6, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AspectRatio(
                    aspectRatio: 0.66,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        tag: 'cover_${widget.cover}',
                        child: Image.asset(
                          widget.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      width: 39,
                      height: 39,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        icon: Consumer<FavoriteBooksModel>(
                          builder: (context, favoriteBooksModel, child) {
                            final isFavorite = favoriteBooksModel
                                .favoriteBookIds
                                .contains('${widget.id}');
                            return Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            );
                          },
                        ),
                        onPressed: () {
                          final favoriteBooksModel =
                              Provider.of<FavoriteBooksModel>(context,
                                  listen: false);
                          final isFavorite = favoriteBooksModel.favoriteBookIds
                              .contains('${widget.id}');
                          final increase = !isFavorite;
                          widget.updateFavourite(increase: increase);
                          favoriteBooksModel.toggleFavorite('${widget.id}');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16.0, height: 1.1),
            ),
            const SizedBox(height: 2.0),
            Text(
              widget.author,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
