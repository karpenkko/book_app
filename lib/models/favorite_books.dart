import 'package:flutter/material.dart';

class FavoriteBooksModel extends ChangeNotifier {
  List<String> favoriteBookIds = [];

  void toggleFavorite(String bookId) {
    if (favoriteBookIds.contains(bookId)) {
      favoriteBookIds.remove(bookId);
    } else {
      favoriteBookIds.add(bookId);
    }
    notifyListeners();
  }
}
