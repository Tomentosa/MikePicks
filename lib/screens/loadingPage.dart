import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0x9CCCE2AC),
          child: Center(child: Lottie.asset('lib/images/loading.json')),
        ),
      ),
    );
  }
}
