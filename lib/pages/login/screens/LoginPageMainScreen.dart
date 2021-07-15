import 'package:consumatron/pages/login/components/LoginForm.dart';
import 'package:flutter/material.dart';

class LoginPageMainScreen extends StatefulWidget {
  const LoginPageMainScreen({Key? key}) : super(key: key);

  @override
  _LoginPageMainScreenState createState() => _LoginPageMainScreenState();
}

class _LoginPageMainScreenState extends State<LoginPageMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [LoginForm()],
      ),
    );
  }
}
