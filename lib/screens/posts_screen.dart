import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/modul/Posts.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/screens/post_comments_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:intl/intl.dart';

import '../const/const.dart';
import '../widget/reusblePost.dart';

final _firestore = FirebaseFirestore.instance;

class PostsScreen extends StatefulWidget {
  static const String ID = "PostsScreen";

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

DateFormat format = DateFormat("MMMM dd, yy");
var dateString = format.format(DateTime.now());
DateFormat dayFormat = DateFormat("EEEE");
var dayString = dayFormat.format(DateTime.now());

DateTime sentTime = DateTime.now();

final postController = TextEditingController();

class _PostsScreenState extends State<PostsScreen> {
  List _postsList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getPostsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
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
                          icon: Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                        Column(
                          children: [
                            Text(
                              dayString + "  " + dateString,
                              style: const TextStyle(color: primaryColor, fontSize: 18),
                            ),
                            Text(
                              "Hi, " + (userList.isNotEmpty ? toBeginningOfSentenceCase(userList[3])! : ''),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                              hintText: 'What\'s in your mind ?',
                              hintStyle: const TextStyle(color: lightTextColor),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    sentTime = DateTime.now();
                                    if (postController.text.isEmpty) {
                                    } else {
                                      _firestore.collection('Posts').doc(postController.text).set(
                                        {
                                          'sender email': loggedInUserEmail,
                                          'sender name':
                                              '${toBeginningOfSentenceCase(userList[3])} ${toBeginningOfSentenceCase(userList[2])}',
                                          'time': sentTime,
                                          'post': postController.text
                                        },
                                      );
                                      postController.clear();
                                    }
                                  });
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                            controller: postController,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: ListView.builder(
                          itemCount: _postsList.length,
                          itemBuilder: (context, index) {
                            int reverseIndex = _postsList.length - 1 - index;
                            getPostsList();
                            return ReusblePost(_postsList[reverseIndex] as Posts);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
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
