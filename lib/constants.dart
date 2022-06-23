import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLightBtn, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kLogoBright, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: kLogoBright,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
  filled: true,
  fillColor: kActiveCardColor,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kLogoBright, width: 2.0),
  ),
  color: kActiveCardColor,
);

const Color kActiveCardColor = Color(0xFF1D1E33);
const Color kLightBtn = Color(0xFF6F7693);
const Color kInactiveCardColor = Color(0xFF111328);
const Color kPinkBtn = Color(0xFFEB1555);
const Color kLogoBright = Color(0xFFFFBB10);
const Color kReceiverColor = Color(0XFFfcbc0c);
