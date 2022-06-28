import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Posts.dart';
import 'package:icare/screens/add_relative_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

class NotificationsScreen extends StatefulWidget {
  static const String ID = "NotificationsScreen";

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Posts> _postsList = [];
  List<Posts> _notificationList = [];

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Notifications',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Image.asset('assets/images/notifications.png',height: 100)
                          ],
                        ),
                        /*Expanded(
                          child: _notificationList.isEmpty
                              ? Image.asset(
                            'assets/images/no_data.png',
                            width: 200,
                          )
                              : ListView.builder(
                              itemCount: _notificationList.length,
                              itemBuilder: (context, index) {
                                getUserAppointmentList();
                                return reusbleAppointment(_notificationList[index] as Posts);
                              }),
                        ),*/
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

  Future getPostsList() async {
    var postsData = await FirebaseFirestore.instance
        .collection('Posts').where('sender email', isEqualTo: loggedInUserEmail)
        .orderBy('time', descending: true)
        .get();


    if (!mounted) return;

    setState(() {
      _postsList = postsData.docs.map<Posts>((collection) => Posts.fromSnapshot(collection)).toList();
    });
  }
}
