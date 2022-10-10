import 'package:flutter/material.dart';
import 'package:sql_note/const/linkapi.dart';
import 'package:sql_note/model/notmodel.dart';

class CardNote extends StatelessWidget {
  final void Function() ontap;
  final void Function() onDelete;
  // final String title;
  // final String text;
  NoteModel notemodel;

  CardNote(
      {Key? key,
      required this.ontap,
      // required this.title,
      // required this.text,
      required this.notemodel,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    "$linkimage/${notemodel.noteImage}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: GridPaper(
                      interval: 40,
                      child: ListTile(
                        title: Text('${notemodel.noteTitle}'),
                        subtitle: Text('${notemodel.noteText}'),
                        trailing: IconButton(
                            onPressed: onDelete, icon: Icon(Icons.delete)),
                      ),
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 7,
        )
      ],
    );
  }
}
