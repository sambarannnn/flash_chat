import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚡️ FlashChat'),
      ),
      // backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/flash_icon.png'),
                    height: 150.0,
                  ),
                ),
              ],
            ),
            // Center(
            //   child: Text(
            //     'FlashChat',
            //     style: TextStyle(
            //       fontFamily: 'Blogger_Sans',
            //       fontSize: 70.0,
            //       fontWeight: FontWeight.w700,
            //       color: kLogoBright,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 45.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
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
                  'Register',
                ),
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
