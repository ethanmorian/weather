import 'package:flutter/material.dart';
import 'package:instagram/screen/login.dart';
import 'package:instagram/screen/signup.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool a = true;

  void go() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return Login(go);
    } else {
      return Signup(go);
    }
  }
}
