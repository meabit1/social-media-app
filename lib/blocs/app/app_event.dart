part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutEvent extends AppEvent {}

class AppUserChangeEvent extends AppEvent {
  final User user;
  const AppUserChangeEvent(this.user);
  @override
  List<Object> get props => [user];
}
