import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/service_locators.dart';
import 'package:ggy_twitter_clone/src/controllers/auth_controllers.dart';

import 'package:ggy_twitter_clone/src/screens/navHomePage.dart';
import 'package:ggy_twitter_clone/src/screens/navProfilePage.dart';
import 'package:ggy_twitter_clone/src/screens/navSearchPage.dart';
import 'package:ggy_twitter_clone/src/widgets/iconbottombar.dart';

class HomeScreen extends StatefulWidget {
  static const String route = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _auth = locator<AuthController>();
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

  final List<Widget> _children = [
    navHomePage(),
    navSearchPage(),
    navProfilePage(),
  ];

  scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 250));
    print('scrolling to bottom');
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        curve: Curves.easeIn, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/twitter.png',
              fit: BoxFit.contain,
              height: 30,
            ),
          ],
        ),

        // title: Text(user != null ? user!.username : '. . .'),
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 25),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent,width: 9),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
            
        child: BottomAppBar(
          elevation: 0,
          child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconBottomBar(
                      text: "",
                      icon: Icons.home_rounded,
                      selected: _selectedIndex == 0,
                      onPressed: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                    ),
                    IconBottomBar(
                        text: "Search",
                        icon: Icons.search,
                        selected: _selectedIndex == 1,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        }),
                    IconBottomBar(
                        text: "Calendar",
                        icon: Icons.person,
                        selected: _selectedIndex == 2,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}


