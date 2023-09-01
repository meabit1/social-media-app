import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/my_user.dart';

enum AppStatus { authanticated, unauthenticated }

class AppController extends GetxController {
  // helpers
  final _firebaseInstance = FirebaseAuth.instance;
  StreamSubscription<User?>? _streamSubscription;
  // fields
  final Rx<AppStatus> _appStatus = AppStatus.unauthenticated.obs;
  AppStatus get appStatus => _appStatus.value;
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  MyUser currentUser = MyUser(id: '', email: '');
  // handlers
  sinUp(String email, String password) async {
    try {
      _isLoading.value = true;
      await _firebaseInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      _isLoading.value = false;
    } catch (_) {}
  }

  signIn(String email, String password) async {
    try {
      _isLoading.value = true;
      await _firebaseInstance.signInWithEmailAndPassword(
          email: email, password: password);
      _isLoading.value = false;
    } catch (_) {}
  }

  signOut() {
    _firebaseInstance.signOut();
  }

  @override
  void onInit() {
    _streamSubscription =
        _firebaseInstance.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        _appStatus.value = AppStatus.unauthenticated;
      } else {
        _appStatus.value = AppStatus.authanticated;
        currentUser = firebaseUser.toMyUser;
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription!.cancel();
    super.onClose();
  }
}

extension on User {
  MyUser get toMyUser {
    return MyUser(id: uid, email: email!);
  }
}
