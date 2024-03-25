import 'package:flutter/material.dart';

class BookNavBar extends StatefulWidget{
  final TabController tabController;

  const BookNavBar({
    super.key,
    required this.tabController,
  });

  @override
  State<BookNavBar> createState() => _BookNavBarState();
}

class _BookNavBarState extends State<BookNavBar> {
  @override


  Widget build(BuildContext context){
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/flag_ua.png',
            height: 32,
          ),
          label: 'Ukrainian books',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/icons/flag_uk.png',
            height: 32,
          ),
          label: 'English books',
        ),
      ],
      currentIndex: widget.tabController.index,
      onTap: (int index) {
        setState(() {});
        widget.tabController.animateTo(index);
      },
      backgroundColor: Colors.black87,
      selectedFontSize: 14,
      unselectedFontSize: 12,
    );


  // Widget build(BuildContext context){
  //   return Container(
  //     color: Colors.black87,
  //     child: TabBar(
  //       controller: widget.tabController,
  //       indicatorSize: TabBarIndicatorSize.tab,
  //       indicator: BoxDecoration(
  //         color: Colors.white24,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       labelColor: Colors.white,
  //       tabs: [
  //         Tab(
  //           icon: Image.asset(
  //             'assets/icons/flag_ua.png',
  //             height: 32,
  //           ),
  //           text: 'Ukrainian books',
  //         ),
  //         Tab(
  //           icon: Image.asset(
  //             'assets/icons/flag_uk.png',
  //             height: 32,
  //           ),
  //           text: 'English books',
  //         ),
  //       ],
  //     ),
  //   );



  }
}



