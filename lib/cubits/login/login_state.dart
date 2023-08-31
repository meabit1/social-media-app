part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, succes, error }

class LoginState extends Equatable {
  final LoginStatus status;
  final String password;
  final String email;
  const LoginState({
    required this.status,
    required this.password,
    required this.email,
  });
  factory LoginState.initial() {
    return const LoginState(
      status: LoginStatus.initial,
      password: '',
      email: '',
    );
  }
  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
