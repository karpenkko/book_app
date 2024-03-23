import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_books.dart';
import 'book_info_page.dart';


class FavoriteDrawer extends StatefulWidget {
  final List uaData;
  final List ukData;

  const FavoriteDrawer({
    super.key,
    required this.uaData,
    required this.ukData,
  });

  @override
  State<FavoriteDrawer> createState() => _FavoriteDrawerState();
}

class _FavoriteDrawerState extends State<FavoriteDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 90,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('Favorite books',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          for (var item in widget.uaData)
            ListTile(
              leading: Hero(
                tag: 'cover_${item['cover']}',
                child: Container(
                  width: 36,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item['cover']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title: Text(item['name']),
              trailing: IconButton(
                icon: Consumer<FavoriteBooksModel>(
                  builder: (context, favoriteBooksModel, child) {
                    final isFavorite = favoriteBooksModel.favoriteBookIds.contains('${item['id']}');
                    return Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    );
                  },
                ),
                onPressed: () {
                  final favoriteBooksModel = Provider.of<FavoriteBooksModel>(context, listen: false);
                  favoriteBooksModel.toggleFavorite('${item['id']}');
                  print(favoriteBooksModel.favoriteBookIds);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(
                      title: item['name'],
                      author: item['author'],
                      cover: item['cover'],
                      description: item['description'],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}