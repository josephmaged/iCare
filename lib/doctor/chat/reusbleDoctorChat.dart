import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/doctor/chat/doctor_chat_screen.dart';
import 'package:icare/modul/Users.dart';

class reusbleDoctorChat extends StatelessWidget {
  final Users _users;

  const reusbleDoctorChat(this._users, {Key? key}) : super(key: key);

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
                    builder: (context) => doctorChatScreen(),
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
          style: const TextStyle(color: darkTextColor),
        ),
        /*subtitle: Text(
          "test",
          style: TextStyle(color: lightTextColor),
        ),*/
        trailing: const Icon(Icons.chat_rounded, size: 30, color: primaryColor),
      ),
    );
  }
}
