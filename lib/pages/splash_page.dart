

import 'dart:async';

import 'package:firebase_example/data/api/auth_api.dart';
import 'package:firebase_example/pages/home_page.dart';
import 'package:firebase_example/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final _authApi = AuthApi();

  @override
  void initState() {
    super.initState();

    // run timer for 2 seconds then check user login status
    // navigate user according to login status
    Timer.periodic(const Duration(seconds: 3), (timer) {
      timer.cancel();
      if (_authApi.isLoggedIn()) {
        // navigate to HomePage
        Navigator.pushReplacement(context, PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        ));
      }else {
        // navigate to LoginPage
        Navigator.pushReplacement(context, PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
        ));
      }
    },);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            "assets/images/app_icon.jpg",
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
