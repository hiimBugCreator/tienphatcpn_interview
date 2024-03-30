import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger_beauty/logger_beauty.dart';
import 'package:tienphatcpn_interview/pages/home/bloc/home_bloc.dart';
import 'package:tienphatcpn_interview/pages/home/view/home_screen.dart';
import 'package:tienphatcpn_interview/pages/launcher/view/launcher_screen.dart';
import 'package:tienphatcpn_interview/pages/login/bloc/login_page_bloc.dart';
import 'package:tienphatcpn_interview/pages/login/view/login_page.dart';

import 'authentication/bloc/authentication_bloc.dart';
import 'constants/lv_app_enums.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    logDebug("App started");
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(),
        ),
        BlocProvider<LoginPageBloc>(
          create: (_) => LoginPageBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    context.read<AuthenticationBloc>().add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => LauncherScreen.route(),
    );
  }
}
