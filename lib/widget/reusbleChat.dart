// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Users.dart';
import 'package:icare/screens/chat/chat_screen.dart';

class reusbleChat extends StatelessWidget {
  final Users _users;

  reusbleChat(this._users);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListTile(
        onTap: () =>
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => chatScreen(),
                    settings: RouteSettings(arguments: _users.userEmail)
                ),
              ),
            },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/images/doctor.jpg",
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          "${_users.firstName}",
          style: TextStyle(color: darkTextColor),
        ),
        /*subtitle: Text(
          "test",
          style: TextStyle(color: lightTextColor),
        ),*/
        trailing: Icon(Icons.chat_rounded, size: 30, color: primaryColor),
      ),
    );
  }
}
