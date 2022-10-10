import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_note/page/add.dart';
import 'package:sql_note/page/home.dart';
import 'package:sql_note/page/login.dart';
import 'package:sql_note/page/signup.dart';
import 'package:sql_note/page/update.dart';

late SharedPreferences sharedpref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedpref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'new',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: sharedpref.getString('id') == null ? "login" : "home",
      // home: Login(),
      routes: {
        'home': (context) => Home(),
        'login': (context) => Login(),
        'signup': (context) => Signup(),
        'add': (context) => AddNote(),
        'update': (context) => updateNote(),
      },
    );
  }
}
