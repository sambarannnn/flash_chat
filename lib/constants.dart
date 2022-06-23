import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: kLogoBright,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kLogoBright, width: 2.0),
  ),
);

const Color kActiveCardColor = Color(0xFF1D1E33);
const Color kLightBtn = Color(0xFF6F7693);
const Color kInactiveCardColor = Color(0xFF111328);
const Color kPinkBtn = Color(0xFFEB1555);
const Color kLogoBright = Color(0xFFFFBB10);
