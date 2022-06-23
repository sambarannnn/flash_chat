import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        body: Column(
          children: [
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
                    textAlign: TextAlign.center,
                    obscureText: true,
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
                      child: Text(
                        'Log In',
                      ),
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        if (email != null && password != null) {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email!, password: password!);
                            if (user != null) {
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
          ],
        ),
      ),
    );
  }
}
