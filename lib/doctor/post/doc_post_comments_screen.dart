import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icare/doctor/doctor_home.dart';
import 'package:icare/modul/Posts.dart';
import 'package:icare/widget/reusbleComment.dart';
import 'package:intl/intl.dart';



final _firestore = FirebaseFirestore.instance;

class docPostCommentsScreen extends StatefulWidget {
  static const String ID = "DocPostCommentsScreen";

  const docPostCommentsScreen({Key? key}) : super(key: key);

  @override
  State<docPostCommentsScreen> createState() => _docPostCommentsScreenState();
}

var postArg;
String? senderName;
String? postContent;
DateTime sentTime = DateTime.now();
final commentController = TextEditingController();

class _docPostCommentsScreenState extends State<docPostCommentsScreen> {
  List _commentsList = [];

  @override
  Widget build(BuildContext context) {
    postArg = ModalRoute.of(context)!.settings.arguments;
    Posts _post = postArg;
    String getPost = _post.post!;

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _post.senderName!,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 7),
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
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              CommentsStream(getPost: getPost),
              Column(
                children: [
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
                                    'sender email': loggedInDoctorEmail,
                                    'sender name':
                                    '${toBeginningOfSentenceCase(docData['First Name'])} ${toBeginningOfSentenceCase(docData['Last Name'])}',
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
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
/*
  Future getCommentsList() async {
    var data = await FirebaseFirestore.instance.collection('Posts').doc(postArg).collection('Comments').get();
    setState(() {
      _commentsList = List.from(data.docs.map((collection) => Comments.fromSnapshot(collection)));
    });
  }*/
}


class CommentsStream extends StatelessWidget {
  String getPost;
  CommentsStream({required this.getPost});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:_firestore
          .collection('Posts').doc(getPost).collection('Comments').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final comments = snapshot.data?.docs;
        List<ReusbleComment> commentBubbles = [];
        for (var comment in comments!) {
          final postText = comment.get('comment');
          final senderName = comment.get('sender name');
          final senderEmail = comment.get('sender email');
          final commentTime = comment.get('time');


          final commentBubble = ReusbleComment(
            comment: postText,
            senderName: senderName,
          );

            commentBubbles.add(commentBubble);

        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: commentBubbles,
          ),
        );
      },
    );
  }
}

