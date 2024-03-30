import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tienphatcpn_interview/authentication/bloc/authentication_bloc.dart';
import 'package:tienphatcpn_interview/components/lv_card.dart';
import 'package:tienphatcpn_interview/components/lv_loading.dart';
import 'package:tienphatcpn_interview/components/lv_message.dart';
import 'package:tienphatcpn_interview/constants/string_constant.dart';
import 'package:tienphatcpn_interview/extensions/number_extension.dart';
import 'package:tienphatcpn_interview/pages/login/bloc/login_page_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  bool obscureText = true;
  bool isCheckedRemember = false;
  bool incorrectAccount = false;
  late LoginPageBloc bloc = BlocProvider.of<LoginPageBloc>(context);
  late AuthenticationBloc authBloc =
      BlocProvider.of<AuthenticationBloc>(context);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errMessage = "";

  @override
  void initState() {
    bloc.add(InitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  OutlineInputBorder outlineInputBorder(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: color));

  Center titlePage() => Center(
        child: Text(
          loginTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );

  Widget get errorMessage => (incorrectAccount)
      ? LVMessage(
          message: errMessage,
          color: Theme.of(context).colorScheme.errorContainer,
          prefixIcon: const Icon(Icons.error_outline),
          textStyle: TextStyle(color: Theme.of(context).colorScheme.error))
      : Container();

  Widget get cardView => SizedBox(
    child: Row(
      children: [
        const Spacer(flex: 1),
        Expanded(
          flex: 8,
          child: LVCard(
            elevation: 100,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ..._buildLoginFormWidget,
                  Row(
                    children: [
                      Expanded(child: buildSignInButton()),
                    ],
                  ),
                  20.vertical,
                ],
              ),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    ),
  );

  Widget get mainLayout => BlocConsumer<LoginPageBloc, LoginPageState>(
        listener: (context, state) async {
          if (state is LoginPageSuccess) {
            authBloc.add(AuthenticationSuccess());
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: cardView,
              ),
              state is LoginPageLoading ? const LVLoading() : Container()
            ],
          );
        },
      );

  List<Widget> get _buildLoginFormWidget {
    return [
      20.vertical,
      titlePage(),
      20.vertical,
      errorMessage,
      BlocConsumer<LoginPageBloc, LoginPageState>(
        listener: (context, state) {
          if (state is LoginPageFailure) {
            incorrectAccount = true;
            errMessage = state.msg;
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: userName,
                    border: OutlineInputBorder(),
                  ),
                ),
                16.vertical,
                TextField(
                  controller: _passwordController,
                  obscureText: true, // Ẩn văn bản khi nhập mật khẩu
                  decoration: const InputDecoration(
                    labelText: password,
                    border: OutlineInputBorder(),
                  ),
                ),
                16.vertical,
              ],
            ),
          );
        },
      ),
    ];
  }

  Widget buildSignInButton() {
    return SizedBox(
        height: 56,
        child: InkWell(
          onTap: () async {
            try {
              if (_formKey.currentState!.validate()) {
                bloc.add(PressingLoginEvent(
                  username: _usernameController.value.text,
                  password: _passwordController.value.text,
                ));
              }
            } catch (error) {
              rethrow;
            }
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).primaryColor),
            child: const Center(
                child: Text(
              loginTitle,
              style: TextStyle(color: Colors.white),
            )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: mainLayout,
    );
  }
}
