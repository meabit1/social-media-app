part of 'signup_cubit.dart';

enum SignupStatus { success, error, submitting, initial }

class SignupState extends Equatable {
  final SignupStatus status;
  final String email;
  final String password;
  final String confirmPassword;
  const SignupState({
    required this.status,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  factory SignupState.initial() {
    return const SignupState(
      status: SignupStatus.initial,
      email: '',
      password: '',
      confirmPassword: '',
    );
  }
  SignupState copyWith({
    SignupStatus? status,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignupState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object> get props => [email, password, confirmPassword, status];
}
