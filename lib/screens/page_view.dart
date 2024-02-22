import 'package:delivery_app/logg/logger.dart';
import 'package:delivery_app/screens/main_screens/cart_screen.dart';
import 'package:delivery_app/screens/main_screens/restaurants_screen.dart';
import 'package:flutter/material.dart';

import 'main_screens/account_screen.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  int _selectedIndex = 0;
  List itemsToCart = [];

void addItemToCart(int itemId) {
  logger.i(itemsToCart);
    setState(() {
      itemsToCart.add(itemId);
    });
  }

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: [
            RestaurantScreen(addItemToCart: addItemToCart),
            CartScreen(itemsToCart: itemsToCart),
            //AccountScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF383434),
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color(0xFFf0fc8c),
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.restaurant_outlined,
              ),
              label: 'deals',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              label: 'Cart',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.account_circle_outlined,
            //   ),
            //   label: 'Account',
            // ),
          ],
          onTap: (value) {
            _pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ));
  }
}
