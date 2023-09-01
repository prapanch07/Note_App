
import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/firebase/auth.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/screens/sign_up_screen.dart';
import 'package:note_app/widgets/custom_snack_bar.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/note_app_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

//logged in check
  @override
  Widget build(BuildContext context) {
    final _emaillogincontroller = TextEditingController();
    final _passlogincontroller = TextEditingController();

    return Scaffold(
      backgroundColor: blackcolor,
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const NoteAppWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(
                  hintText: 'email',
                  controller: _emaillogincontroller,
                  keyboardtype: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomTextField(
                  hintText: 'password',
                  controller: _passlogincontroller,
                  keyboardtype: TextInputType.emailAddress,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: whitecolor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Click here ',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(yellowcolor),
                    ),
                    onPressed: () async {
                      final pref = await SharedPreferences.getInstance();

                      if (_emaillogincontroller.text.isNotEmpty &&
                          _passlogincontroller.text.isNotEmpty) {
                        final res = await AuthMethods().login(
                          email: _emaillogincontroller.text,
                          password: _passlogincontroller.text,
                        );

                        if (res == "success") {
                          customSnackBar(context, "successfully logged in");

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                              (route) => false);
                          pref.setBool('login', true);
                        } else {
                          customSnackBar(context, res);
                        }
                      } else {
                        customSnackBar(context, "enter credentials");
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: blackcolor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
