import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/views/home_view.dart';
import 'package:flutter_firebase/views/sign_in_view.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        if (appController.appStatus == AppStatus.unauthenticated) {
          return SignInView();
        } else if (appController.appStatus == AppStatus.authanticated) {
          return const HomeView();
        } else {
          return Container();
        }
      }),
    );
  }
}
