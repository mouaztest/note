import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sql_note/comp/textformfiled.dart';
import 'package:sql_note/const/CRUD.dart';
import 'package:sql_note/const/linkapi.dart';
import 'package:sql_note/main.dart';

import '../comp/valid.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with CRUD {
  bool isloading = false;
  CRUD _crud = CRUD();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController passcontrol = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();

  Login() async {
    if (formkey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var respon = await postRequest(loginlink, {
        'email': emailcontrol.text,
        'pass': passcontrol.text,
      });
      isloading = false;
      setState(() {});
      if (respon['status'] == 'success') {
        sharedpref.setString('id', respon['data']['id'].toString());
        sharedpref.setString('email', respon['data']['email']);
        sharedpref.setString('name', respon['data']['name']);

        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
        // AwesomeDialog(
        //   context: context,
        //   dialogType: DialogType.success,
        //   title: 'Success',
        //   dialogBackgroundColor: Colors.green,
        //   desc: 'the login has been successfuly',
        // ).show();
      } else {
        AwesomeDialog(
          dialogType: DialogType.error,
          dialogBackgroundColor: Colors.red,
          context: context,
          title: 'ALERT!!!',
          desc: 'the email OR passord rong OR the account not found',
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(8),
      child: Form(
        key: formkey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AlterText(
            type: TextInputType.emailAddress,
            label: 'EMAIL ADDRESS',
            valid: (val) {
              return validate(val!, 13, 25);
            },
            mycontroller: emailcontrol,
          ),
          AlterText(
            type: TextInputType.visiblePassword,
            label: 'PASSWORD',
            valid: (val) {
              return validate(val!, 3, 25);
            },
            mycontroller: passcontrol,
          ),
          isloading == true
              ? Center(child: CircularProgressIndicator())
              : MaterialButton(
                  onPressed: () async {
                    await Login();
                  },
                  child: const Text('LOGIN'),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  textColor: Colors.white,
                  color: Colors.purple,
                ),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('if you dont have account '),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'signup');
                  },
                  child: const Text('SIGNUP')),
            ],
          ),
        ]),
      ),
    ));
  }
}
