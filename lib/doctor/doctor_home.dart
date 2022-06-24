// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icare/doctor/chat/chat_with_patient.dart';
import 'package:icare/doctor/doctor_profile.dart';
import 'package:icare/doctor/post/docReusblePost.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/const.dart';
import '../modul/Posts.dart';
import '../modul/Users.dart';
import '../screens/login_screen.dart';
import '../services/DataBaseManager.dart';
import '../widget/reusblePost.dart';

final _firestore = FirebaseFirestore.instance;


class doctorHomeScreen extends StatefulWidget {
  static const String ID = "DoctorHomeScreen";

  @override
  _doctorHomeScreenState createState() => _doctorHomeScreenState();
}

final _auth = FirebaseAuth.instance;
var loggedInDoctor;
var loggedInDoctorEmail;
List userList = [];

DateTime sentTime = DateTime.now();

final postController = TextEditingController();

class _doctorHomeScreenState extends State<doctorHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List _postsList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPostsList();
  }


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // <-- SEE HERE
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false; //<-- SEE HERE
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchDatabaseList();
  }

  void getCurrentUser() {
    try {
      final doctor = _auth.currentUser;
      if (doctor != null) {
        loggedInDoctor = doctor;
        loggedInDoctorEmail = doctor.email;
      }
    } catch (e) {
      print(e);
    }
  }

  fetchDatabaseList() async {
    dynamic resultdata = await DataBaseManager().getUserData(email: loggedInDoctorEmail);
    if (resultdata == null) {
      print("enable to get ");
    } else {
      setState(() {
        userList = resultdata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.lightBlueAccent.withOpacity(0.5), BlendMode.dstATop),
                        image: AssetImage("assets/images/drawerBackground.jpg"),
                        fit: BoxFit.fitWidth,
                      )),
                  child: Image.asset(
                    "assets/images/mainLogo.png",
                    alignment: Alignment.topLeft,
                    color: primaryColor,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.chat_rounded),
                  title: const Text('Chat with patients'),
                  onTap: () {
                    Navigator.of(context).pushNamed(chatWithPatientScreen.ID);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('LogOut'),
                  onTap: () async {
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.remove('email');
                    final SharedPreferences rulePreference = await SharedPreferences.getInstance();
                    rulePreference.remove('ruleId');

                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed(LoginScreen.ID);
                  },
                ),
              ],
            ),
          ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                          icon: Icon(Icons.menu),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                        Text(
                          "Hi, DR: " + (userList.isNotEmpty ? toBeginningOfSentenceCase(userList[5])! : ''),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(DoctorProfile.ID),
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: /*PostStream(),*/
                        ListView.builder(
                          itemCount: _postsList.length,
                          itemBuilder: (context, index) {
                            int reverseIndex = _postsList.length - 1 - index;
                            getPostsList();
                            return DocReusblePost(_postsList[reverseIndex] as Posts);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
  Future getPostsList() async {
    var data = await FirebaseFirestore.instance.collection('Posts').orderBy('time').get();
    setState(() {
      _postsList = List.from(data.docs.map((collection) => Posts.fromSnapshot(collection)));
    });
  }
}
/*
class PostStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Posts').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final posts = snapshot.data?.docs.reversed;
        List<ReusblePost> postStream = [];
        for (var post in posts!) {
          final postText = post.get('post');
          final postSenderName = post.get('sender name');
          final postSenderEmail = post.get('sender email');
          final postTime = post.get('time');

          final reusblePost = ReusblePost(
            senderName: postSenderName,
            senderEmail: postSenderEmail,
            time: postTime,
            postText: postText,
          );

          postStream.add(reusblePost);
        }
        return ListView(
          shrinkWrap: true,
          children: postStream,
        );
      },
    );
  }
}*/

