import 'package:crm_client/feature/presentation/view/screens/home_screens/profile_screen.dart';
import 'package:crm_client/feature/presentation/view/widgets/app_header.dart';
import 'package:flutter/material.dart';

import '../../widgets/floating_button.dart';
import 'main_screen.dart';
import 'news_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  int _selectedIndex = 1;

  void _onPageClicked(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 135, bottom: 85, right: 10, left: 10),
                  child: ProfileScreen(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 135, bottom: 85, right: 10, left: 10),
                  child: MainScreen(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 135, bottom: 85, right: 10, left: 10),
                  child: NewsScreen(),
                ),
              ],
            ),
            MenuFloatingButton(
              onIconTap: _onPageClicked,
              selectedIndex: _selectedIndex,
            ),
            HomeHeader()
          ],
        ),
      ),
    );
  }
}