import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'app.dart';

void main() async {
  // initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initializing controllers
  Get.put(AppController());
  // starting the app
  runApp(const App());
}
