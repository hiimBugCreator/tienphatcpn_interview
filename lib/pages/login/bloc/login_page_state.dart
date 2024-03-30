part of 'login_page_bloc.dart';

@immutable
abstract class LoginPageState {}

class LoginPageInitial extends LoginPageState {}
class LoginPageLoading extends LoginPageState {}
class LoginPageSuccess extends LoginPageState {}
class LoginPageFailure extends LoginPageState {
  final String msg;
  LoginPageFailure({required this.msg});
}
