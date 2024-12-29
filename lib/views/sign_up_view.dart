import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/views/sign_in_view.dart';
import 'package:get/get.dart';

import '../widgets/loading_widget.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // controllers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();
  bool isObsecure = true;
  void toggleObsecure() {
    setState(() {
      isObsecure = !isObsecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _passwordController,
                obscureText: isObsecure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  prefixIcon: IconButton(
                      onPressed: toggleObsecure,
                      icon: isObsecure
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _confirmPasswordController,
                obscureText: isObsecure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password',
                  prefixIcon: IconButton(
                      onPressed: toggleObsecure,
                      icon: isObsecure
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Obx(
                () {
                  return appController.isLoading
                      ? const LoadingWidget()
                      : ElevatedButton(
                          onPressed: () {
                            if (_emailController.text.trim().isEmpty ||
                                _passwordController.text.trim().isEmpty ||
                                _confirmPasswordController.text
                                    .trim()
                                    .isEmpty) {
                              Get.snackbar(
                                  "Sign up failed", "All fields are required");
                              return;
                            }
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              Get.snackbar(
                                  "Sign up failed", "Passwords dont match");
                              return;
                            }
                            appController.sinUp(_emailController.text.trim(),
                                _passwordController.text);
                          },
                          child: const Text('Sign Up'),
                        );
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Or login if you have one'),
                  TextButton(
                    onPressed: () {
                      Get.off(() => SignInView());
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
