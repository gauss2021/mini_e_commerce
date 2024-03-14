import 'package:flutter/material.dart';
import 'package:mini_e_commerce/Providers/cart_provider.dart';
import 'package:mini_e_commerce/config.dart';
import 'package:mini_e_commerce/screens/cart.dart';
import 'package:mini_e_commerce/screens/products_list.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

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
    List<Map<String, dynamic>> cart = Provider.of<CartProvider>(context).cart;
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
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 24,
                ),
                label: ''),
            cart.isNotEmpty
                ? BottomNavigationBarItem(
                    icon: badges.Badge(
                      badgeContent: Text(cart.length.toString()),
                      child: const Icon(Icons.shopping_bag),
                    ),
                    label: '')
                : const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_bag,
                      size: 24,
                    ),
                    label: '')
          ]),
      body: IndexedStack(
        index: currentIndexOfBottomNavigationBar,
        children: pages,
      ),
    );
  }
}
