import 'package:cloud_firestore/cloud_firestore.dart';

class notemodel {
  final String text;
  final String noteID;
  final String title;
  final DateTime date;
  final bool updateval;

  notemodel({
    required this.title,
    required this.text,
    required this.noteID,
    required this.date,
    required this.updateval,
  });

  Map<String, dynamic> tojson() => {
        "note": text,
        "noteID": noteID,
        "title": title,
        "date": date,
        "updateval": updateval
      };

  static notemodel fromSnaptoUserm(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return notemodel(
      text: snapshot['username'],
      title: snapshot['title'],
      noteID: snapshot['noteID'],
      date: snapshot['date'],
      updateval: snapshot['updateval'],
    );
  }
}
