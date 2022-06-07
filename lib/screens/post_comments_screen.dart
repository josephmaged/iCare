import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/modul/Posts.dart';
import 'package:icare/widget/reusbleComment.dart';
import 'package:intl/intl.dart';

import '../modul/Comments.dart';
import '../widget/reusblePost.dart';
import 'home_screen.dart';


final _firestore = FirebaseFirestore.instance;

class postCommentsScreen extends StatefulWidget {
  static const String ID = "PostCommentsScreen";

  @override
  State<postCommentsScreen> createState() => _postCommentsScreenState();
}

var postArg;
String? senderName;
String? postContent;
DateTime sentTime = DateTime.now();
final commentController = TextEditingController();

class _postCommentsScreenState extends State<postCommentsScreen> {
  List _commentsList = [];

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCommentsList();
  }

  @override
  Widget build(BuildContext context) {
    postArg = ModalRoute.of(context)!.settings.arguments;
    Posts _post = postArg;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.grey,
          iconSize: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _post.senderName!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: const Color(0XFFF5F5F5), borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _post.post!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _commentsList.length,
                    itemBuilder: (context, index) {
                      int reverseIndex = _commentsList.length - 1 - index;
                      getCommentsList();
                      return ReusbleComment(_commentsList[reverseIndex] as Comments);
                    },
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Add Comment",
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: Colors.grey,
                    iconSize: 30,
                    padding: const EdgeInsets.all(5),
                    onPressed: () {
                      setState(() {
                        sentTime = DateTime.now();
                        if (commentController.text.isEmpty) {
                        } else {
                          _firestore.collection('Posts').doc(_post.post).collection('Comments').add(
                            {
                              'sender email': loggedInUserEmail,
                              'sender name':
                              '${toBeginningOfSentenceCase(userList[3])} ${toBeginningOfSentenceCase(userList[2])}',
                              'time': sentTime,
                              'comment': commentController.text
                            },
                          );
                          commentController.clear();
                        }
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future getCommentsList() async {
    var data = await FirebaseFirestore.instance.collection('Posts').doc(postArg).collection('Comments').get();
    setState(() {
      _commentsList = List.from(data.docs.map((collection) => Comments.fromSnapshot(collection)));
    });
  }
}
