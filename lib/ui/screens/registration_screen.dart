import 'package:assignment/ui/screens/login_screen.dart';
import 'package:assignment/ui/widget/commonElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Firebase Connection/auth.dart';
import '../utils/dialogUtils.dart';
import '../utils/styles.dart';
import '../widget/common_text_field.dart';
import '../widget/have_account_or_not.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isLoading = false;
  final Auth _auth = Auth(); // Create an instance of Auth
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  "assets/images/logo.jpg",
                  height: 110,
                  width: 110,
                ),
                Text(
                  "Welcome!",
                  style: titleTextStyle,
                ),
                const SizedBox(height: 4),
                Text(
                  "Please fill your the registration form.",
                  style: subTitleTextStyle,
                ),
                const SizedBox(
                  height: 16,
                ),
                CommonTextField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                  controller: _nameController,
                  hintText: 'Your Name',
                ),
                const SizedBox(
                  height: 8,
                ),
                CommonTextField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your email';
                    }
                    final emailRegex =
                        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                    if (!emailRegex.hasMatch(value!)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                  controller: _emailController,
                  hintText: 'Email Address',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 8,
                ),
                CommonTextField(
                  validator: (value) {
                    if (value?.length != 6) {
                      return 'Enter your password (must be 6 digit)';
                    }
                    return null;
                  },
                  controller: _passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 16,
                ),
                _isLoading
                    ? const CircularProgressIndicator()
                    : CommonElevatedButton(
                        title: "Register",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (mounted) {
                              setState(() {
                                _isLoading = true;
                              });
                            }
                            _auth.registerUser(
                              _nameController,
                              _emailController,
                              _passwordController,
                              context,
                            );
                            DialogUtils.showAlertDialog(
                                context, 'Registration Success');
                          } else {
                            DialogUtils.showAlertDialog(
                                context, 'Registration Failed');
                          }
                        },
                      ),
                HaveAccountOrNot(
                  content: "Already have an account?",
                  buttonName: 'Login',
                  onPressed: () {
                    Get.off(const LoginScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
