import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sql_note/comp/textformfiled.dart';
import 'package:sql_note/comp/valid.dart';
import 'package:sql_note/const/CRUD.dart';
import 'package:sql_note/const/linkapi.dart';
import 'package:sql_note/main.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isloading = false;
  CRUD _crud = CRUD();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController passcontrol = TextEditingController();
  TextEditingController usernamecontrol = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();

  Signup() async {
    if (formkey.currentState!.validate()) {
      isloading = true;
      setState(() {});
      var response = await _crud.postRequest(signuplink, {
        "name": usernamecontrol.text,
        "email": emailcontrol.text,
        "pass": passcontrol.text,
      });
      isloading = false;
      setState(() {});

      if (response['status'] == 'success') {
        sharedpref.setString('id', response['data']['id'].toString());
        sharedpref.setString('email', response['data']['email']);
        sharedpref.setString('name', response['data']['name']);

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
        padding: const EdgeInsets.all(8),
        child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlterText(
                  valid: (String? val) {
                    return validate('$val', 13, 25);
                  },
                  hint: 'email',
                  mycontroller: emailcontrol,
                ),
                AlterText(
                  valid: (String? val) {
                    return validate('$val', 3, 25);
                  },
                  hint: 'username',
                  mycontroller: usernamecontrol,
                ),
                AlterText(
                  valid: (String? val) {
                    return validate('$val', 3, 25);
                  },
                  hint: 'password',
                  mycontroller: passcontrol,
                ),
                isloading == true
                    ? Center(child: CircularProgressIndicator())
                    : MaterialButton(
                        onPressed: () async {
                          await Signup();
                        },
                        child: const Text('SignUp'),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 20),
                        textColor: Colors.white,
                        color: Colors.purple,
                      ),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('if you have account? '),
                    const SizedBox(
                      width: 3,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text('Login')),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
