import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:football_picks/screens/Log%20In/Create%20New%20Account.dart';
import 'package:football_picks/screens/homepage.dart';
import '../../Comm/genTextFormField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _username = TextEditingController();
String username ="";
final _password = TextEditingController();
String password ="";

class _LoginPageState extends State<LoginPage> {
  late StreamSubscription<bool> subscription;

  @override
  void initState() {
    super.initState();

    subscription =
        KeyboardVisibilityController().onChange.listen((isVisible) {});
  }

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0x9CCCE2AC),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTextFormField(
                controller: _username,
                hintName: 'Username / E-Mail',
                icon: Icons.man,
                isObscureText: false,
              ),
              const SizedBox(height: 25),
              getTextFormField(
                controller: _password,
                icon: Icons.lock,
                hintName: 'Password',
                isObscureText: true,
              ),
              const SizedBox(height: 23),
              TextButton(
                onPressed: () {
                  username=_username.text;
                  password=_password.text;

                  FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen.shade500),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19.0),
                            side: const BorderSide(color: Colors.black54)))),
                child: const Text(
                  '  Sign In  ',
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ),
              Visibility(
                  visible: !isKeyboard,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      //create new account text button
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("I  need  to"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CreateNewAccount()),
                                );
                              },
                              child: const Text("Create New Account"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Oops"),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password"),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
