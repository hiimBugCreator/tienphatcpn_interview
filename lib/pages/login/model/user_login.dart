import 'dart:convert';

import 'package:crypto/crypto.dart';

class UserLogin {
  final String username;
  final String _password;
  final String id;
  final String name;
  final String avatar;

  UserLogin({
    required this.username,
    required String password,
    this.id = "",
    this.name = "",
    this.avatar = "",
  }) : _password = sha256.convert(utf8.encode(password)).toString();

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': _password,
      };

  String get password => _password;

  bool isMatch(UserLogin rq) {
    return (password == rq.password && username == rq.username);
  }

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      username: json["username"] != null ? json["username"] as String : "",
      id: json["id"] != null ? json["id"] as String : "",
      name: json["name"] != null ? json["name"] as String : "",
      avatar: json["avatar"] != null ? "${json["avatar"]}.jpg" : "",
      password: json["password"] != null ? json["password"] as String : "",
    );
  }
}
