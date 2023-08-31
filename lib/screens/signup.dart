import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/cubits/signup/signup_cubit.dart';
import 'package:flutter_firebase/repositories/auth.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static Route route() =>
      MaterialPageRoute(builder: ((context) => const SignUpScreen()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => SignupCubit(context.read<AuthRepository>()),
        child: _SignupForm(),
      ),
    );
  }
}

class _SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EmailInput(),
          const SizedBox(height: 20),
          _PasswordInput(),
          const SizedBox(height: 20),
          _ConfirmPasswordInput(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SignupButton(),
              const SizedBox(width: 20),
              _LoginButton(),
            ],
          )
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return TextField(
          // obscureText: true,
          onChanged: (password) =>
              context.read<SignupCubit>().confirmPasswordChanged(password),
          decoration: const InputDecoration(labelText: 'Confirm Password'),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          // obscureText: true,
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SignupStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              duration: Duration(milliseconds: 1200),
              content: Text('Passwords dont match'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == SignupStatus.submitting) {
          return const CircularProgressIndicator();
        } else {
          return ElevatedButton(
            onPressed: () => context.read<SignupCubit>().signup(),
            child: const Text('Sign up'),
          );
        }
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('login'),
    );
  }
}
