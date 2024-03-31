import 'package:flutter/material.dart';

class FloatingFavouriteButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int favouriteCount;

  const FloatingFavouriteButton({
    super.key,
    required this.scaffoldKey,
    required this.favouriteCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.favorite,
                size: 34,
                color: Colors.white,
              ),
              Positioned(
                top: 6,
                child: Text(
                  '$favouriteCount',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
