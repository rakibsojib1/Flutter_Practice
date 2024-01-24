import 'package:assignment/ui/widget/commonElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Firebase Connection/auth.dart';
import '../utils/styles.dart';
import '../widget/common_text_field.dart';
import '../widget/have_account_or_not.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _isLoading = false;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  final Auth _auth = Auth();

  Future<void> _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    await _auth.loginUser(
      _emailController.text,
      _passwordController.text,
      _emailController,
      _passwordController,
      context,
    );
    setState(() {
      _isLoading = false;
    });
  }

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
                  "Welcome Back!",
                  style: titleTextStyle,
                ),
                const SizedBox(height: 4),
                Text(
                  "Please enter your Email address and password.",
                  style: subTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
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
                        title: "Login",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _isLoading = true;
                            _loginUser(); // Pass context to _loginUser
                          }
                        },
                      ),
                HaveAccountOrNot(
                  content: "Don not have an account?",
                  buttonName: 'Register',
                  onPressed: () {
                    Get.off(const RegistrationScreen());
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
