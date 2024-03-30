part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent {}

class AuthenticationSuccess extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
