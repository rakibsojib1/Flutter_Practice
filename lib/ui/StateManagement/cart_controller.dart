import 'package:get/get.dart';

class CartController extends GetxController {
  RxInt cartItemCount = 0.obs;
  RxList<Product> cartItems = <Product>[].obs;

  void addToCart(Product product) {
    cartItemCount++;
    cartItems.add(product);
  }

  void removeFromCart(Product product) {
    cartItemCount--;
    cartItems.remove(product);
  }
}

class Product {
  final String name;
  final String image;

  Product({required this.name, required this.image});
}
