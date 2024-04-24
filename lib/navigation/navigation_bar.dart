import 'package:authentication/chats/screens/chats_screen.dart';
import 'package:authentication/profile/profile_screen.dart';
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
    PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          ChatsScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 116, 165, 249),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GNav(
          
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              activeColor: Colors.white,
              color: Colors.white,
              tabBackgroundColor: Colors.white.withOpacity(0.4),
              gap: 8,
              onTabChange: (index){
                  _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
              },
              padding: EdgeInsets.all(14),
              tabs: [
              GButton(icon: Icons.chat,text: 'Chats',),
              GButton(icon: Icons.man, text: 'Profile',),
            
            ],
                    
                ),
          )));
  }
  void ChangeView(index){

  }
}