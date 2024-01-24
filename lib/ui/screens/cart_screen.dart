import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../StateManagement/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Cart List',
        ),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _cartController.cartItems.length,
          itemBuilder: (context, index) {
            final product = _cartController.cartItems[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.asset(product.image),
                title: Text(product.name),
                trailing: ElevatedButton(
                  onPressed: () {
                    _cartController.removeFromCart(product);
                  },
                  child: const Text('Remove'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
