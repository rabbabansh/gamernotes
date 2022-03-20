import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev show log;

import 'package:flutter/widgets.dart';
import 'package:gamernotes/constants/routes.dart';
import 'package:gamernotes/main.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GamerNotes'),
        backgroundColor: const Color.fromARGB(255, 7, 255, 28),
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TextField(
              controller: _email,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'type out the email bruda man',
                  labelText: 'Email')),
          TextField(
            controller: _password,
            autocorrect: false,
            obscureText: true,
            enableSuggestions: false,
            decoration: const InputDecoration(
                labelText: 'Password', hintText: 'gg ez poggers'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                Navigator.of(context).pushNamedAndRemoveUntil(
                  notesRoute,
                  (route) => false,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  dev.log('User Not Found');
                } else if (e.code == 'wrong-password') {
                  dev.log('Wrong Password');
                } else {
                  dev.log("SOMEthing happened");
                  dev.log(e.code);
                }
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text('Not a gamer yet? Register!'))
        ],
      ),
    );
  }
}
