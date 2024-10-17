import 'dart:async';

import 'package:crud_app/view/homescreen.dart';
import 'package:crud_app/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      checkLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 200,
              color: Color.fromARGB(255, 255, 191, 0),
            ),
            Text(
              "STUDENTS LIST",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 191, 0), fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future checkLogin() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    bool isLoggedIn = prefes.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return HomeScreen();
      }));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return SignupPage();
      }));
    }
  }
}
