import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/bottom_nav_bar_screen.dart';
import '../screens/login_screen.dart';

class Auth {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // instance of FirebaseFirestore

  Future<void> registerUser(
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(emailController.text).set({
        'name': nameController.text,
        'email': emailController.text,
      });

      // Registration successful
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      Get.off(const LoginScreen());
    } on FirebaseAuthException catch (e) {
      // Registration failed
      print(e);
    }
  }

  Future<void> loginUser(
    String email,
    String password,
    TextEditingController emailController,
    TextEditingController passwordController,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Login successful
      emailController.clear();
      passwordController.clear();
      Get.off(const BottomNavBarScreen());
    } on FirebaseAuthException catch (e) {
      // Login failed
      print(e);
    }
  }

  Future<User?> checkUserAuthentication() async {
    return await FirebaseAuth.instance.authStateChanges().first;
  }

  Widget handleAuth() {
    return FutureBuilder<User?>(
      future: checkUserAuthentication(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          return const BottomNavBarScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  // Logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  //get userId
  // Get User ID
  String? getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}
