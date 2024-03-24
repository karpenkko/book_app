import 'package:flutter/material.dart';
import 'models/favorite_books.dart';
import 'screens/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteBooksModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookish',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

