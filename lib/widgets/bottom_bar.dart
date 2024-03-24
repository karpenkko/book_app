import 'package:flutter/material.dart';

class BookNavBar extends StatelessWidget implements PreferredSizeWidget{
  final TabController tabController;

  const BookNavBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context){
    return TabBar(
      controller: tabController,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kBottomNavigationBarHeight);
}