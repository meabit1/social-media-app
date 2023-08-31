import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/cubits/login/login_cubit.dart';
import 'package:flutter_firebase/repositories/auth.dart';
import 'package:flutter_firebase/screens/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static Page page() => const MaterialPage<void>(child: LoginScreen());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(context.read<AuthRepository>()),
        child: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            const SizedBox(height: 20),
            _PasswordInput(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LoginButton(),
                const SizedBox(width: 20),
                _SignUpButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          decoration: const InputDecoration(labelText: 'Password'),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == LoginStatus.submitting) {
          return const CircularProgressIndicator();
        } else {
          return ElevatedButton(
            onPressed: () => context.read<LoginCubit>().loginWithCredentials(),
            child: const Text('Login'),
          );
        }
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(SignUpScreen.route());
      },
      child: const Text('Sign Up'),
    );
  }
}
