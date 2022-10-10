import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sql_note/comp/valid.dart';
import 'package:sql_note/const/CRUD.dart';
import 'package:sql_note/const/linkapi.dart';
import 'package:sql_note/main.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with CRUD {
  File? myfile;
  // File? imfile=File(Image.network())
  Image? image;
  TextEditingController title = TextEditingController();
  TextEditingController text = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isloading = false;

  fofo() async {
    if (myfile == null) {
      return image = Image.network(
          "2bbdc313b-4f88-4e2a-8acf-f2551144135e7727747573634313957.jpg");
    } else {
      return myfile!;
    }
  }

  addnote() async {
    if (formkey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      if (formkey.currentState!.validate()) {
        var respon = await postRequestFile(
          addlink,
          {
            "title": title.text,
            "text": text.text,
            "id": sharedpref.getString("id")
          },
          myfile!,
        );

        isloading = false;
        setState(() {});
        if (respon['status'] == 'success') {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('home', (route) => false);
        }
      } else {
        print('error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (contex) {
                      return Container(
                        height: 100,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SELECT IMAGE FROM :',
                                style: TextStyle(fontSize: 22),
                              ),
                              InkWell(
                                onTap: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.camera);
                                  Navigator.of(context).pop();
                                  myfile = File(xfile!.path);
                                  setState(() {});
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'From Camera',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  Navigator.of(context).pop();
                                  myfile = File(xfile!.path);
                                  setState(() {});
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'From Galery',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              )
                            ]),
                      );
                    });
              },
              icon: myfile == null
                  ? Icon(
                      Icons.image_outlined,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.image_outlined,
                      color: Colors.green,
                    )),
          IconButton(
              onPressed: () async {
                await addnote();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.all(8),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            return validate(val!, 0, 40);
                          },
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                          //          onChanged: (e) {
                          //   setState(() {
                          //     text = e as TextEditingController;
                          //   });
                          // },
                          controller: title,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.5, style: BorderStyle.solid)),
                              hintText:
                                  '                   Write Here your note title.....'),
                        ),
                        TextFormField(
                          validator: (val) {
                            return validate(val!, 1, 255);
                          },
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: null,
                          controller: text,
                          //          onChanged: (e) {
                          //   setState(() {
                          //     text = e as TextEditingController;
                          //   });
                          // },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write Here .....'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
