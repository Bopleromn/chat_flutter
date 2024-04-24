import 'package:authentication/chats/screens/chats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 8,
      tabs: [
      GButton(icon: Icons.chat),
      GButton(icon: Icons.man),
      GButton(icon: Icons.settings)

    ]);
  }
}