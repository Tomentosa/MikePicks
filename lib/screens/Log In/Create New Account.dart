import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:football_picks/comm/comHelper.dart';
import '../../Comm/genTextFormField.dart';
import '../homepage.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _createUserName = TextEditingController();
  String username = "";

  final _password = TextEditingController();
  String password = "";

  final _confirmPassword = TextEditingController();
  String cPassword = "";

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
                  controller: _createUserName,
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
                const SizedBox(height: 25),
                getTextFormField(
                  controller: _confirmPassword,
                  icon: Icons.lock,
                  hintName: 'Confirm Password',
                  isObscureText: true,
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    username = _createUserName.text;
                    password = _password.text;
                    cPassword = _confirmPassword.text;

                    _checkFields();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightGreen.shade500),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(19.0),
                              side: const BorderSide(color: Colors.black54)))),
                  child: const Text(
                    '  Create New Account  ',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Support Methods
  //Create a user using an anonymous/temporary account
  Future<void> _createUserCustom() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unkown error.");
      }
    }
  }

//Create a user with e-mail and password
  Future<void> _checkFields() async {
    if (_formKey.currentState!.validate()) {
      if (password != cPassword) {
        alertDialog(context, 'Passwords do not match!');
      } else {
        _createUserEmail();
      }
    }
    print('Password: $password, Check:$cPassword, do they match?${password == cPassword}');
  }

  Future<void> _createUserEmail() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);
      alertDialog(context, 'Account Created');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unkown error: $e");
      }
    }
  }
}
