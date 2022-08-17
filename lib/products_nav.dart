import 'package:flutter/material.dart';

import 'products_cart.dart';
import 'products_discover.dart';

class HomeProductsNavBar extends StatefulWidget {
  const HomeProductsNavBar({Key? key}) : super(key: key);

  @override
  State<HomeProductsNavBar> createState() => _HomeProductsNavBarState();
}

class _HomeProductsNavBarState extends State<HomeProductsNavBar> {
  int _currentIndex = 1;
  Widget getWidgets(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: Text("Home"),
        );
      case 1:
        return const HomeProductsDiscover();
      case 2:
        return const ProductsCart();
      case 3:
        return const Center(
          child: Text("Profile"),
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Color.fromARGB(255, 212, 175, 55),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: getWidgets(_currentIndex),
    );
  }
}
