import 'package:flutter/material.dart';

import '../menu/home_screen/home_screen.dart';
import '../menu/profile/profile_screen.dart';




class TabBarScreen extends StatefulWidget {

  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TodoApp'),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: const TabBar(tabs: [
              Tab(
               // icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
               // icon: Icon(Icons.person),
                text: 'Profile',
              )
            ]),
          ),
          body: const TabBarView(
            children: [
              HomeScreen(),
              ProfileScreen()
            ],
          ),
        )
    );
  }
}
