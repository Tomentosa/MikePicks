import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Comm/genTextFormField.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final _createUserName = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

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
                  //TODO Logic to either create a user with an e mail
                  //or a user with a username/password
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
    );
  }

  /// Support Methods
  //Create a user using an anonymous/temporary account
  Future<void> _createUser() async {
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


}
