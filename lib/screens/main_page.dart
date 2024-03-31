import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:book_app/screens/books_page.dart';
import 'package:book_app/models/read_json.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/fav_drawer.dart';
import '../widgets/floating_heart.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  int favourite = 0;
  // bool isDarkMode = false;

  void updateFavourite({increase = true}) {
    setState(() {
      increase ? favourite++ : favourite--;
    });
  }

  // void toggleTheme() {
  //   setState(() {
  //     isDarkMode = !isDarkMode;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  var darkTheme = ThemeData.dark(useMaterial3: true);
  var lightTheme = ThemeData.light(useMaterial3: true);

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      // data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: BookAppBar(
          darkTheme: darkTheme,
          lightTheme: lightTheme,
          // isDarkMode: isDarkMode,
          // toggleTheme: toggleTheme,
        ),
        drawer: FutureBuilder(
          future: ReadJsonFile.readJsonData(path: 'assets/sample.json'),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final jsonData = snapshot.data!;
              return FavoriteDrawer(
                  uaData: jsonData['UA'],
                  ukData: jsonData['UK'],
                  updateFavourite: updateFavourite);
            }
          },
        ),
        body: FutureBuilder(
          future: ReadJsonFile.readJsonData(path: 'assets/sample.json'),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final jsonData = snapshot.data!;
              return TabBarView(
                controller: tabController,
                children: [
                  BooksPage(
                      jsonData: jsonData['UA'],
                      updateFavourite: updateFavourite),
                  BooksPage(
                      jsonData: jsonData['UK'],
                      updateFavourite: updateFavourite),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: BookNavBar(tabController: tabController),
        floatingActionButton: FloatingFavouriteButton(
          scaffoldKey: scaffoldKey,
          favouriteCount: favourite,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
