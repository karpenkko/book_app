import 'package:flutter/material.dart';

class BookAppBar extends StatelessWidget implements PreferredSizeWidget{
  const BookAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black87,
      title: const Text('Bookishness'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(null),
        onPressed: () {},
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}