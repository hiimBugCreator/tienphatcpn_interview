part of 'login_page_bloc.dart';

@immutable
abstract class LoginPageEvent {}

class PressingLoginEvent extends LoginPageEvent {
  final String username;
  final String password;

  PressingLoginEvent({required this.username, required this.password,});
}

class InitialEvent extends LoginPageEvent {}
