import 'package:flutter/material.dart';
import 'package:mini_e_commerce/config.dart';
import 'package:mini_e_commerce/screens/cart.dart';
import 'package:mini_e_commerce/screens/products_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndexOfBottomNavigationBar = 0;

  List<Widget> pages = const [ProductsList(), Cart()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.white,
          backgroundColor: Config.morePrimaryColor,
          selectedItemColor: Config.secondaryColor,
          currentIndex: currentIndexOfBottomNavigationBar,
          onTap: (value) {
            setState(() {
              currentIndexOfBottomNavigationBar = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '')
          ]),
      body: IndexedStack(
        index: currentIndexOfBottomNavigationBar,
        children: pages,
      ),
    );
  }
}
