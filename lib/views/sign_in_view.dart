import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/views/sign_up_view.dart';
import 'package:flutter_firebase/widgets/loading_widget.dart';
import 'package:get/get.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  // controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
              const Text(
                'Sign In',
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
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) return;
                        appController.signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                      child: Obx(
                        () => appController.isLoading
                            ? const LoadingWidget()
                            : const Text('Sign In'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(() => SignUpView());
                    },
                    child: const Text('Sign Up'),
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
