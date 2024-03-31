import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

class BookAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeData darkTheme;
  final ThemeData lightTheme;
  // final bool isDarkMode;
  // final VoidCallback toggleTheme;

  const BookAppBar({
    super.key,
    required this.darkTheme,
    required this.lightTheme,
    // required this.isDarkMode,
    // required this.toggleTheme
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black87,
      title: const Text(
        'Bookishness',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(null),
        onPressed: () {},
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
      //     ),
      //     onPressed: toggleTheme,
      //   ),
      // ],
      actions: [
        ThemeSwitcher(
          clipper: const ThemeSwitcherCircleClipper(),
          builder: (context) {
            return IconButton(
              icon: Icon(
                color: Colors.red,
                ThemeModelInheritedNotifier.of(context).theme.brightness ==
                        Brightness.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                var brightness =
                    ThemeModelInheritedNotifier.of(context).theme.brightness;
                ThemeSwitcher.of(context).changeTheme(
                  theme:
                      brightness == Brightness.light ? darkTheme : lightTheme,
                  isReversed: brightness == Brightness.light ? true : false,
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
