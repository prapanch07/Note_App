import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';
import 'package:note_app/firebase/firestore.dart';
import 'package:note_app/screens/home_screen.dart';
import 'package:note_app/widgets/custom_elevated_button.dart';

class UpdateNoteScreen extends StatefulWidget {
  final noteID;
  final title;
  final text;
  const UpdateNoteScreen({
    super.key,
    required this.noteID,
    required this.title,
    required this.text,
  });

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  final _updatedtitlecontroller = TextEditingController();
  final _updatedtextcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _updatedtextcontroller.text = widget.text;
      _updatedtitlecontroller.text = widget.title;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Update Note (${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}  ${DateTime.now().hour}:${DateTime.now().minute})",
          style: const TextStyle(
            color: blackcolor,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 84, 85, 77),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          children: [
            TextField(
              controller: _updatedtitlecontroller,
              maxLength: 20,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Heading",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 187, 175, 141),
                  fontSize: 20,
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
                  controller: _updatedtextcontroller,
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
            title: const Text("Update Note ?"),
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
                        await firestore().updatenote(
                          widget.noteID,
                          _updatedtextcontroller.text,
                          _updatedtitlecontroller.text,
                        );

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false);
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
