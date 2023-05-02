import 'package:chat_ai/constants/pallete.dart';
import 'package:chat_ai/screens/drawer.dart';
import 'package:chat_ai/screens/homepage.dart';
import 'package:flutter/material.dart';

import 'screens/cart_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedindex = 0;

  List<Widget> pages = [
    const HomePage(),
     CartScreen(),
     AppDrawer()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedindex,
          onTap: _onTaped,
          selectedItemColor: Pallete.buttonColor,
          unselectedItemColor: const Color(0xFFD7D5D5),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_checkout), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ]),
    );
  }

  void _onTaped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }
}
