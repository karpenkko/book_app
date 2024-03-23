import 'package:book_app/screens/books_page.dart';
import 'package:book_app/models/read_json.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import 'fav_drawer.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  late Future<Map<String, dynamic>> jsonData;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const BookAppBar(),
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
            );
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
              controller: _tabController,
              children: [
                BooksPage(jsonData: jsonData['UA']),
                BooksPage(jsonData: jsonData['UK']),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(8),
        ),
        labelColor: Colors.white,
        tabs: [
          Tab(
            icon: Image.asset(
              'assets/icons/flag_ua.png',
              height: 32,
            ),
            text: 'Ukrainian books',
          ),
          Tab(
            icon: Image.asset(
              'assets/icons/flag_uk.png',
              height: 32,
            ),
            text: 'English books',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.red,
        child: const Icon(Icons.favorite),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}