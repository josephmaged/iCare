import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/screens/add_relative_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';
import 'notifications_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String ID = "UserDetailsScreen";

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                        Row(
                          children: [
                            Hero(
                              tag: "appbarImage",
                              child: Image.asset('assets/images/patient.png'),
                            ),
                            Text(
                              'Hello, \n${toBeginningOfSentenceCase(userList[3])!}',
                              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 400),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(UserProfileScreen.ID),
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primaryColor),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Profile information',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        /*GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(NotificationsScreen.ID),
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primaryColor),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Notifications',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),*/
                        const SizedBox(height: 35),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(AddRelativeScreen.ID),
                          child: Container(
                            height: 55,
                            padding: const EdgeInsets.only(left: 15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primaryColor),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Add Relatives',
                                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
