import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:note_app/model/note_model.dart';
import 'package:uuid/uuid.dart';

class firestore {
  final _firestore = FirebaseFirestore.instance;

  Future<String> uploadnote({
    required String title,
    required String text,
    required String uid,
  }) async {
    String res = 'error occured';

    try {
      String noteID = const Uuid().v1();
      notemodel note = notemodel(
        text: text,
        title: title,
        noteID: noteID,
        date: DateTime.now(),
        updateval: false,
      );
      _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('note')
          .doc(noteID)
          .set(
            note.tojson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> deletenote(String noteID) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('note')
          .doc(noteID)
          .delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updatenote(String noteID, String text, String title) async {
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('note')
          .doc(noteID)
          .update({
        'title': title,
        'note': text,
        'date': DateTime.now(),
        'updateval': true
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
