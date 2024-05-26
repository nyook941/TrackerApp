import 'package:flutter/material.dart';
import 'package:poop_tracker/screens/calendar_tracker.dart';
import 'package:poop_tracker/screens/entry.dart';
import 'package:poop_tracker/screens/loading.dart';

void main() => runApp(MaterialApp(initialRoute: '/calendar', routes: {
      '/': (context) => const Loading(),
      '/calendar': (context) => const CalendarTacker(),
      '/entry': (context) => const EntryScreen()
    }));

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
        color: Colors.white,
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
