import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_books.dart';
import '../screens/book_info_page.dart';


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
  late List allBooks;
  late List favoriteBooks = [];

  void createBookList(){
    final favoriteBooksModel = Provider.of<FavoriteBooksModel>(context, listen: false);
    allBooks = [...widget.uaData, ...widget.ukData];

    final List<String> favoriteBookIds = favoriteBooksModel.favoriteBookIds;
    favoriteBooks.addAll(allBooks.where((item) => favoriteBookIds.contains('${item['id']}') && !favoriteBooks.contains(item)));
    favoriteBooks.removeWhere((item) => !favoriteBookIds.contains('${item['id']}') && favoriteBooks.contains(item));

  }

  @override
  void initState() {
    super.initState();
    createBookList();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const BouncingScrollPhysics(),
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
          for (var item in favoriteBooks)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListTile(
                leading: Hero(
                  tag: 'cover_${item['id']}_${item['cover']}',
                  child: Container(
                    width: 36,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      image: DecorationImage(
                        image: AssetImage(item['cover']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  item['name'],
                  style: const TextStyle(
                    height: 1.1,
                  ),
                ),
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
                    setState(() {
                      createBookList();
                    });
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
            ),
        ],
      ),
    );
  }
}