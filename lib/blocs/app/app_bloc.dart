import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase/repositories/auth.dart';

import '../../models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;

  // constructor

  AppBloc({required authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<AppUserChangeEvent>(_onUserChanged);
    on<AppLogoutEvent>(_onLogout);
    _userSubscription = _authRepository.user.listen((user) {
      add(AppUserChangeEvent(user));
    });
  }

  // events handlers
  _onUserChanged(AppUserChangeEvent event, Emitter<AppState> emitter) {
    emitter(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  _onLogout(AppLogoutEvent event, Emitter<AppState> emitter) {
    unawaited(_authRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription!.cancel();
    return super.close();
  }
}
