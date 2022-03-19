import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  hintText: 'type out the email bruda man', labelText: 'Email')),
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
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: password);
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('User Not Found');
                } else if (e.code == 'wrong-password') {
                  print('Wrong Password');
                } else {
                  print("SOMEthing happened");
                  print(e.code);
                }
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: const Text('Not a gamer yet? Register!'))
        ],
      ),
    );
  }
}
