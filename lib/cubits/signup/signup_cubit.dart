import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase/repositories/auth.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  SignupCubit(this._authRepository) : super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void confirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPassword: value));
  }

  Future<void> signup() async {
    if (state.status == SignupStatus.submitting) return;
    if (state.confirmPassword != state.password) {
      emit(state.copyWith(status: SignupStatus.error));
      emit(state.copyWith(status: SignupStatus.submitting));
      await Future.delayed(const Duration(milliseconds: 1500));
      emit(state.copyWith(status: SignupStatus.initial));
    }

    if (state.confirmPassword.isEmpty || state.password.isEmpty) return;

    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      await _authRepository.signUp(
          email: state.email, password: state.password);
      emit(state.copyWith(status: SignupStatus.success));
    } catch (_) {}
  }
}
