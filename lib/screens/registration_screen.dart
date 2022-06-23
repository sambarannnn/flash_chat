import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('⚡️ FlashChat'),
        ),
        // backgroundColor: Colors.white,
        body: Column(children: [
          Visibility(
            visible: showSpinner,
            child: LinearProgressIndicator(
              color: kLogoBright,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset('images/flash_icon.png'),
                          height: 150.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RoundedButton(
                    color: kLogoBright,
                    child: const Text(
                      'Register',
                    ),
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      if (email != null && password != null) {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email!, password: password!);
                          if (newUser != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    })
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
