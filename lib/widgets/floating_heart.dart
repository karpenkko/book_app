import 'package:flutter/material.dart';

class FloatingFavouriteButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int favouriteCount;

  const FloatingFavouriteButton({
    super.key,
    required this.scaffoldKey,
    required this.favouriteCount,
  });

  @override
  State<FloatingFavouriteButton> createState() =>
      _FloatingFavouriteButtonState();
}

class _FloatingFavouriteButtonState extends State<FloatingFavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: () {
            widget.scaffoldKey.currentState!.openDrawer();
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
                  '${widget.favouriteCount}',
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
