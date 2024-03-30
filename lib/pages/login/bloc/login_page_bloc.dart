import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:logger_beauty/logger_beauty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienphatcpn_interview/constants/string_constant.dart';
import 'package:tienphatcpn_interview/extensions/reading_extension.dart';
import 'package:tienphatcpn_interview/pages/login/model/user_login.dart';

part 'login_page_event.dart';

part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitial()) {
    on<PressingLoginEvent>(_onPressingLoginEvent);
    on<InitialEvent>(_onInitialLoginEvent);
  }

  Future<void> _onPressingLoginEvent(
      PressingLoginEvent event, Emitter<LoginPageState> emit) async {
    emit(LoginPageLoading());
    logDebug(event.username);
    logDebug(event.password);
    var model = UserLogin(password: event.password, username: event.username);
    var rs = await callAPILogin(model);
    if (rs) {
      logDebug(model);
      logDebug("Login success");
      emit(LoginPageSuccess());
    } else {
      logDebug("Login failed");
      emit(LoginPageFailure(
          msg: errLogin));
    }

  }

  Future<bool> callAPILogin(UserLogin model) async {
    var isSuccess = await requestLogin(model);
    return isSuccess;
  }

  void _onInitialLoginEvent(
      LoginPageEvent event, Emitter<LoginPageState> emit) {
  }

  Future<bool> requestLogin(UserLogin model) async {
    await Future.delayed(const Duration(seconds: 5), () {
      logDebug(updatedData);
    });
    var listData = await readJsonFromAssets(authFilePath);
    for (var element in listData) {
      logDebug(element);
      if (model.isMatch(UserLogin.fromJson(element))) {
        var u = UserLogin.fromJson(element);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(userId, u.id);
        prefs.setString(avt, u.avatar);
        prefs.setString(name, u.name);
        return true;
      }
    }
    return false;
  }

}
