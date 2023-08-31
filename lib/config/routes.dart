import 'package:flutter/material.dart';
import 'package:flutter_firebase/blocs/app/app_bloc.dart';

import '../screens/home.dart';
import '../screens/login.dart';

List<Page> onGeneratAppViewPages(AppStatus status, List<Page> pages) {
  switch (status) {
    case AppStatus.authenticated:
      return [HomeScreen.page()];
    case AppStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
