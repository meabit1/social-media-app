import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/blocs/app/app_bloc.dart';
import 'package:flutter_firebase/config/routes.dart';
import 'package:flutter_firebase/repositories/auth.dart';
import 'package:flow_builder/flow_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authRepository = AuthRepository();
  runApp(
    App(
      authRepository: authRepository,
    ),
  );
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  const App({super.key, required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: _authRepository),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlowBuilder(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGeneratAppViewPages,
      ),
    );
  }
}
