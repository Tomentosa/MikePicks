import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:football_picks/main.dart';
import 'package:football_picks/screens/Log%20In/Create%20New%20Account.dart';
import 'package:football_picks/screens/homepage.dart';
import 'package:lottie/lottie.dart';
import '../../Comm/genTextFormField.dart';

///Variable Definitions
final _formKey = new GlobalKey<FormState>();

final _username = TextEditingController();
String username ="";
final _password = TextEditingController();
String password ="";
bool loading = false;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late StreamSubscription<bool> subscription;

  @override
  void initState() {
    super.initState();

    //This is used to monitor whether the keyboard is expanded or not
    subscription =
        KeyboardVisibilityController().onChange.listen((isVisible) {});
  }

  @override
  void dispose() {
    //This is used to DISPOSE the monitor for the keyboard
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
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
                    _loginProcess();
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
      ),
    );
  }
///Support Methods
  void _loginProcess() {
    username=_username.text;
    password=_password.text;

    var something = FirebaseAuth.instance.signInWithEmailAndPassword(email: username, password: password);

    print('on login this happened: $something');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );

    //Clear the old login information
    _username.clear();
    _password.clear();

    Fluttertoast.showToast(msg: 'Welcome to Mike Picks!');

  }

}

///Support Functions
