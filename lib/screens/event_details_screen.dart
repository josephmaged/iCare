// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';

class eventDetailsScreen extends StatefulWidget {
  static const String ID = "EventScreen";

  @override
  _eventDetailsScreenState createState() => _eventDetailsScreenState();
}

class _eventDetailsScreenState extends State<eventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      color: Colors.grey,
                      iconSize: 35,
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Image.asset('assets/images/tablets/blue_plus.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pill Name',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'test',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Pill Dosage',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'test',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
                Text(
                  'Dose',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'test',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 30),
                Text(
                  'Time',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'test',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 30),
                Text(
                  'Program',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'test',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Center(
                  child: SizedBox(
                    height: 48,
                    width: 274,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        primary: secondaryColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Change Schedule',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
