import 'package:consumatron/models/Credentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

Credentials credentials = Credentials('', '', '');

class _LoginFormState extends State<LoginForm> {
  authenticate() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: credentials.user, password: credentials.authKey);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        child: Form(
            child: Column(
          children: [
            Text('User'),
            TextFormField(
              style: TextStyle(color: Colors.green),
              onChanged: (value) => credentials.user = value,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text('Auth Key'),
            TextFormField(
              style: TextStyle(color: Colors.green),
              onChanged: (value) => credentials.authKey = value,
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: () {
                authenticate();
              },
              child: Text('Authenticate'),
            ),
          ],
        )),
      ),
    );
  }
}
