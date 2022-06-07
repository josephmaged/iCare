import 'package:flutter/material.dart';

const primaryColor = Color(0XFF19417C);
const secondaryColor = Color(0XFFD3F5F7);

const homeIconsColor = Color(0XFF4979d1);

const tipsTestColor = Color(0XFF49505A);

const darkTextColor = Color(0XFF49505A);
const lightTextColor = Color(0XFF867E7E);

const isMeBubbleColor = Color(0XFFD3F5F7);
const isNotMeBubbleColor = Color(0XFFE5E5E5);

const homeMainTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 20
);
const homeDetailsStyle = TextStyle(
  color: Color(0XFF49505a),
  fontSize: 16
);
const homeUpdateStyle = TextStyle(
    fontSize: 16,
    color: Color(0XFF867e7e)
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

