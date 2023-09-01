import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/firebase/auth.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/widgets/custom_text_field.dart';
import 'package:note_app/widgets/note_app_widget.dart';

import '../widgets/custom_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    final _emailsignupcontroller = TextEditingController();
    final _passsignupcontroller = TextEditingController();
    final _namecontroller = TextEditingController();

    pickImage(ImageSource source, BuildContext context) async {
      final _imagepicker = ImagePicker();

      XFile? _file = await _imagepicker.pickImage(source: source);

      if (_file != null) {
        return await _file.readAsBytes();
      } else {
        customSnackBar(context, 'Select an Image');
      }
    }

    void selectImage() async {
      Uint8List? img = await pickImage(ImageSource.gallery, context);

      setState(() {
        image = img;
      });
    }

    return Scaffold(
      backgroundColor: blackcolor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const NoteAppWidget(),
                Stack(
                  children: [
                    Container(
                      child: image != null
                          ? CircleAvatar(
                              // backgroundColor: Colors.blue,
                              radius: 50,
                              backgroundImage: MemoryImage(image!),
                            )
                          : const CircleAvatar(
                              // backgroundColor: Colors.blue,
                              backgroundImage: NetworkImage(
                                  "https://xyzshayari.com/wp-content/uploads/2023/04/no-dp-1-min.png"),
                              radius: 50,
                            ),
                    ),
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: IconButton(
                        onPressed: () => selectImage(),
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.blueAccent,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                    controller: _namecontroller,
                    keyboardtype: TextInputType.name,
                    hintText: 'Name',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                    controller: _emailsignupcontroller,
                    keyboardtype: TextInputType.emailAddress,
                    hintText: 'email',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                      controller: _passsignupcontroller,
                      keyboardtype: TextInputType.visiblePassword,
                      hintText: 'password'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: whitecolor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        '  Click here  ',
                        style: TextStyle(
                          color: yellowcolor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_emailsignupcontroller.text.isNotEmpty &&
                              _passsignupcontroller.text.isNotEmpty &&
                              _namecontroller.text.isNotEmpty &&
                              image != null) {
                            final res = await AuthMethods().signUp(
                              username: _namecontroller.text,
                              email: _emailsignupcontroller.text,
                              password: _passsignupcontroller.text,
                              file: image!,
                            );

                            if (res != "sucess") {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false);
                              customSnackBar(
                                context,
                                'Account created successfully Please Login to Preoceed',
                              );
                            } else {
                              customSnackBar(context, res);
                            }
                          } else {
                            customSnackBar(context, "enter credentials");
                          }
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(yellowcolor)),
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                            color: blackcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
