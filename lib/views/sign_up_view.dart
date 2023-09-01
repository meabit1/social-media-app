import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/views/sign_in_view.dart';
import 'package:get/get.dart';

import '../widgets/loading_widget.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
              const SizedBox(height: 300),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () {
                      return appController.isLoading
                          ? const LoadingWidget()
                          : ElevatedButton(
                              onPressed: () {
                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty &&
                                    _confirmPasswordController
                                        .text.isNotEmpty) {
                                  if (_passwordController.text ==
                                      _confirmPasswordController.text) {
                                    appController.sinUp(_emailController.text,
                                        _passwordController.text);
                                  }
                                }
                              },
                              child: const Text('Sign Up'),
                            );
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
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
