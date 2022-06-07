// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';

class maintainScreen extends StatefulWidget {
  const maintainScreen({Key? key}) : super(key: key);

  @override
  _maintainScreenState createState() => _maintainScreenState();
}

class _maintainScreenState extends State<maintainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: primaryColor,
              ),
              child: Center(
                child: Text(
                  'Tips for maintaining your weight',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 172,
              width: 205,
              child: Image.asset("assets/images/tips_image/25.png"),
            ),
            SizedBox(height: 20),
            Container(
              height: 36,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor),
              ),
              child: Center(
                child: Text(
                  'Eat smaller meals.',
                  style: TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold,),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 172,
              width: 205,
              child: Image.asset("assets/images/tips_image/26.png"),
            ),
            SizedBox(height: 20),
            Container(
              height: 36,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor),
              ),
              child: Center(
                child: Text(
                  'Stay hydrated.',
                  style: TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 172,
              width: 205,
              child: Image.asset("assets/images/tips_image/27.png"),
            ),
            SizedBox(height: 20),
            Container(
              height: 36,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor),
              ),
              child: Center(
                child: Text(
                  'Keep exercising.',
                  style: TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 172,
              width: 205,
              child: Image.asset("assets/images/tips_image/28.png"),
            ),
            SizedBox(height: 20),
            Container(
              height: 36,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor),
              ),
              child: Center(
                child: Text(
                  'Stop eating when you\'re full.',
                  style: TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 172,
              width: 205,
              child: Image.asset("assets/images/tips_image/29.png"),
            ),
            SizedBox(height: 20),
            Container(
              height: 36,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: primaryColor),
              ),
              child: Center(
                child: Text(
                  'Stick to healthy snacks.',
                  style: TextStyle(color: tipsTestColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
