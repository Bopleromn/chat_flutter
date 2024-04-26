import 'package:authentication/authentication/models/user_model.dart';
import 'package:authentication/chats/screens/chats_screen.dart';
import 'package:authentication/core/styles/colors.dart';
import 'package:authentication/core/themes.dart';
import 'package:authentication/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          ChatsScreen(),
          ProfileScreen(user: GetIt.I<UserModel>()),
        ],
      ),
      bottomNavigationBar: Container(
        color: currentTheme.cardColor,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              activeColor: currentTheme.hintColor,
              color: currentTheme.hintColor,
              tabBackgroundColor: currentTheme.hintColor.withOpacity(0.6),
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
          ),
      ),
    );
  }

  void changeView(index){

  }
}