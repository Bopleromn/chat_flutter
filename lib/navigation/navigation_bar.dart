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
    int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 134, 94, 203),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            activeColor: Colors.white,
            color: Colors.white,
            tabBackgroundColor: Color.fromARGB(255, 203, 142, 214),
            gap: 8,
            onTabChange: (index){
              if(index == 0){
                              }
            },
            tabs: [
            GButton(icon: Icons.chat,text: 'Chats',),
            GButton(icon: Icons.man, text: 'Profile',),
          
          ],
        
    )));
  }
}