import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkLoginInfo();
    super.initState();
  }

  bool? isLoggedIn;

  Future<void> checkLoginInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isLoggedIn = pref.getBool('login');

    if (isLoggedIn == null) {
      pref.setBool('login', false);
    }

    Future.delayed(
      const Duration(seconds: 1),
      () {
        isLoggedIn == true
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              )
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: blackcolor,
      body: Center(
        child: Text(
          'NoteApp',
          style: TextStyle(
              color: yellowcolor, fontWeight: FontWeight.w900, fontSize: 60),
        ),
      ),
    );
  }
}
