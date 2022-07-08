import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/doctor/chat/reusbleDoctorChat.dart';
import 'package:icare/modul/Users.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:icare/services/auth_service.dart';
import 'package:icare/widget/reusbleChat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chatWithPatientScreen extends StatefulWidget {
  static const String ID = "ChatWithPatientScreen";

  @override
  _chatWithPatientScreenState createState() => _chatWithPatientScreenState();
}

class _chatWithPatientScreenState extends State<chatWithPatientScreen> {

  List<Object> _userList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsersList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                      ),
                      const Text(
                        'Chats',
                        style: TextStyle(color: primaryColor, fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const IconButton(
                        onPressed: null,
                        icon: const Icon(Icons.segment),
                        color: Colors.grey,
                        iconSize: 35,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      style: const TextStyle(fontSize: 16, height: 0.5),
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _userList.length,
                        itemBuilder: (context, index) {
                          return reusbleDoctorChat(_userList[index] as Users);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getUsersList() async {
    var userData = await FirebaseFirestore.instance.collection('Users').where('Rule ID' ,isEqualTo: "false").get();

    setState(() {
      _userList = List.from(userData.docs.map((collection) => Users.fromSnapshot(collection)));
    });

  }
}
