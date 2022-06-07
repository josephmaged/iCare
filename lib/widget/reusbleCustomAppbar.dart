// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:intl/intl.dart';


DateFormat format = new DateFormat("MMMM dd, yy");
var dateString = format.format(DateTime.now());
DateFormat dayFormat = new DateFormat("EEEE");
var dayString = dayFormat.format(DateTime.now());

class ReusbleCustomAppbar extends StatelessWidget {
  const ReusbleCustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Colors.grey,
          iconSize: 35,
        ),
        Column(
          children: [
            Text(
              dayString + "  " + dateString,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              "Hi, " + (userList.isNotEmpty ? toBeginningOfSentenceCase(userList[3])! : ''),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0XFFD3F5F7)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(UserProfileScreen.ID),
              child: Image.asset(
                'assets/images/doctor.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
