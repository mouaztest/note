import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_note/comp/cardnote.dart';
import 'package:sql_note/const/CRUD.dart';
import 'package:sql_note/const/linkapi.dart';
import 'package:sql_note/main.dart';
import 'package:sql_note/model/notmodel.dart';
import 'package:sql_note/page/update.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with CRUD {
  viewnote() async {
    var respon = await postRequest(viewlink, {
      'id': sharedpref.getString("id"),
    });
    return respon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  sharedpref.clear();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('login', (route) => false);
                },
                icon: Icon(Icons.exit_to_app)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed('add');
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: [
              FutureBuilder(
                  future: viewnote(),
                  builder: ((BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data['status'] == 'fail') {
                        Center(
                            child: Text(
                          'NO NOTES YET',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ));
                      }
                      return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, index) {
                            return CardNote(
                              onDelete: () async {
                                var respon = await postRequest(deletelink, {
                                  'id': snapshot.data['data'][index]['note_id']
                                      .toString(),
                                  'noteimage': snapshot.data['data'][index]
                                          ['note_image']
                                      .toString(),
                                });
                                if (respon['status'] == 'success') {
                                  setState(() {});
                                  // Navigator.of(context).pushNamedAndRemoveUntil(
                                  //     'home', (route) => false);
                                } else {
                                  // setState(() {});/
                                }
                                // setState(() {});
                              },
                              ontap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => updateNote(
                                          notes: snapshot.data['data'][index],
                                        ))));
                              },
                              notemodel: NoteModel.fromJson(
                                  snapshot.data['data'][index]),
                              // title:
                              //     "${snapshot.data['data'][index]['note_title']}",
                              // text:
                              //     "${snapshot.data['data'][index]['note_text']}"
                            );
                          }));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('LOADING....'));
                    }
                    return Center(child: Text('LOADING....'));
                  }))
            ],
          ),
        ));
  }
}
