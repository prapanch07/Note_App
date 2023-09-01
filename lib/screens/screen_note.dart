import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/firebase/firestore.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/widgets/custom_elevated_button.dart';
import 'package:note_app/widgets/custom_snack_bar.dart';

class ScreenNote extends StatelessWidget {
  const ScreenNote({super.key});

  @override
  Widget build(BuildContext context) {
    final _titlecontroller = TextEditingController();
    final _textcontroller = TextEditingController();
    final _size = MediaQuery.sizeOf(context);
    final int _screenHeight = MediaQuery.sizeOf(context).width.toInt();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowcolor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: blackcolor,
          ),
        ),
        title: Text(
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute}",
          style: const TextStyle(
            color: blackcolor,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 84, 85, 77),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _titlecontroller,
              maxLength: 20,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Heading",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 187, 175, 141),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                color: whitecolor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Expanded(
              child: SizedBox(
                width: _size.width,
                child: TextField(
                  controller: _textcontroller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type ur note over here ....",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 187, 175, 141),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  maxLines: _screenHeight,
                  style: const TextStyle(
                    color: whitecolor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellowcolor,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            backgroundColor: backgroundcolor,
            title: const Text("confirm to save"),
            children: [
              SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                      function: () => Navigator.of(context).pop(),
                      text: "cancel",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CustomElevatedButton(
                      function: () async {
                        String res = await firestore().uploadnote(
                          title: _titlecontroller.text,
                          text: _textcontroller.text,
                          uid: FirebaseAuth.instance.currentUser!.uid,
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false);
                        if (res != "success") {
                          customSnackBar(context, res);
                        }
                      },
                      text: "confirm",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        child: const Icon(
          Icons.check_circle,
          color: blackcolor,
          size: 50,
        ),
      ),
    );
  }
}
