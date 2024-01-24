import 'package:assignment/ui/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../StateManagement/cart_controller.dart';
import 'home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(),
  ];

  final CartController _cartController = Get.put(CartController());

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        elevation: 5,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF07ADAE),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Obx(
              () => Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  if (_cartController.cartItemCount.value > 0)
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 7,
                        child: Text(
                          _cartController.cartItemCount.value.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}
