import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:note_app/firebase/auth.dart';

import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/screens/screen_note.dart';
import 'package:note_app/widgets/card.dart';

import 'package:note_app/colors.dart';
import 'package:note_app/widgets/custom_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;

  final _titlecontroller = TextEditingController();
  final _textcontroller = TextEditingController();
  var userdata = {};

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textcontroller;
    _titlecontroller;
  }

  void getUserData() async {
    var usersnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    userdata = usersnap.data()!;
    setState(() {});
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userdata.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: blackcolor,
            appBar: AppBar(
              backgroundColor: yellowcolor,
              leading: null,
              title: const Text(
                "NoteApp",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: blackcolor),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          userdata['username'],
                          style: const TextStyle(
                              color: blackcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            children: [
                              SimpleDialogOption(
                                onPressed: () async {
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();

                                  await AuthMethods().signout();
                                  customSnackBar(
                                      context, 'Logged out successfully');
                                  pref.setBool('login', false);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                      (route) => false);
                                },
                                child: const Text(
                                  'LogOut',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(userdata['photoUrl']),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("note")
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => CardWidget(
                      snapshot: snapshot.data!.docs[index],
                      index: index,
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: yellowcolor,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScreenNote(),
                ),
              ),
              child: const Icon(
                Icons.add,
                color: blackcolor,
                size: 30,
              ),
            ),
          );
  }
}
