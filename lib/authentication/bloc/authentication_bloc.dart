import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger_beauty/logger_beauty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienphatcpn_interview/constants/lv_app_enums.dart';
import 'package:tienphatcpn_interview/constants/string_constant.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(AuthenticationState(AuthenticationStatus.unknown)) {
    on<AuthenticationSuccess>(_onAuthenticationSuccess);
    on<LoggedOut>(_onLogout);
    on<AppStarted>(_onAppStarted);
  }

  String? id;
  String? uname;
  String? uavt;

  _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString(userId) ?? "";
    uavt = prefs.getString(avt) ?? "";
    uname = prefs.getString(name) ?? "";
  }

  Future<void> _onAuthenticationSuccess(
    AuthenticationSuccess event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _getUserInfo();
    emit(AuthenticationState(AuthenticationStatus.authenticated));
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _getUserInfo();
    logDebug(id);
    if (id != null && id!.isNotEmpty) {
      emit(AuthenticationState(AuthenticationStatus.authenticated));
    } else {
      emit(AuthenticationState(AuthenticationStatus.unauthenticated));
    }
  }

  Future<void> _onLogout(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userId);
    prefs.remove(avt);
    prefs.remove(name);
    emit(AuthenticationState(AuthenticationStatus.unauthenticated));
  }
}
