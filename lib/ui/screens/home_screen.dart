import 'package:assignment/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Firebase Connection/auth.dart';
import '../Firebase Connection/fetch_data.dart';
import '../StateManagement/cart_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CartController _cartController = Get.find();

  final FetchData _fetchData = FetchData();
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _fetchUserEmail();
  }

  Future<void> _fetchUserEmail() async {
    String? email = await _fetchData.fetchUserEmail();
    setState(() {
      userEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.amberAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/camera.jpg"),
              const SizedBox(height: 16),
              const Text(
                'Canon Pro 70s',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Best camera ever made!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Buy Now'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _cartController.addToCart(Product(
                        name: 'Canon Pro 70s',
                        image: 'assets/images/camera.jpg',
                      ));
                    },
                    child: const Text('Add to Cart'),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
              if (userEmail != null)
                Text(
                  'User Email: $userEmail',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () {
                    Auth().logout();
                    Get.off(const LoginScreen());
                  },
                  child: const Text("Logout"))
            ],
          ),
        ),
      ),
    );
  }
}
