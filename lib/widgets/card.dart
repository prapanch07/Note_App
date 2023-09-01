import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/firebase/firestore.dart';
import 'package:note_app/screens/update_note_screen.dart';
import 'package:note_app/widgets/custom_snack_bar.dart';

import '../colors.dart';

class CardWidget extends StatefulWidget {
  final index;
  final snapshot;

  const CardWidget({
    super.key,
    required this.index,
    required this.snapshot,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.sizeOf(context);
    bool updateval = widget.snapshot['updateval'];

    return Dismissible(
      background: Container(
        color: greencolor,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'swipe to update',
                style: TextStyle(
                  color: whitecolor,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: whitecolor,
              ),
            ],
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.arrow_back,
                color: whitecolor,
              ),
              Text(
                'swipe to delete',
                style: TextStyle(
                  color: whitecolor,
                ),
              ),
            ],
          ),
        ),
      ),
      key: UniqueKey(),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // update values  not working +++ some bugs login sighnup   ...
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UpdateNoteScreen(
                noteID: widget.snapshot['noteID'],
                text: widget.snapshot['note'],
                title: widget.snapshot['title'],
              ),
            ),
          );

          setState(() {});
        } else {
          customSnackBar(context, "deleted");
          firestore().deletenote(widget.snapshot['noteID']);
        }
      },
      child: SizedBox(
        width: _size.width,
        child: Card(
          elevation: 5,
          color: backgroundcolor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.snapshot['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: blackcolor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      DateFormat.yMMMMd().format(
                        widget.snapshot['date'].toDate(),
                      ),
                    ),
                    updateval
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: greencolor,
                            ),
                          )
                        : const Text('')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.snapshot['note'],
                  style: const TextStyle(
                    color: blackcolor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
