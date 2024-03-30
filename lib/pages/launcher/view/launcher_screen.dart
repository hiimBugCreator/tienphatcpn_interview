import 'package:flutter/material.dart';
import 'package:tienphatcpn_interview/components/lv_loading.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LauncherScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LVLoading(),
    );
  }
}
