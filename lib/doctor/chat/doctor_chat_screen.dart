// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icare/const/const.dart';
import 'package:icare/doctor/doctor_home.dart';
import 'package:icare/modul/Users.dart';
import 'package:icare/screens/chat/chat_screen.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

final _firestore = FirebaseFirestore.instance;

class doctorChatScreen extends StatefulWidget {
  static const String ID = "DoctorChatScreen";

  @override
  _doctorchatScreenState createState() => _doctorchatScreenState();
}

final messageTextController = TextEditingController();
DateTime sentTime = DateTime.now();
late String messageText;

var doctorArg;


class _doctorchatScreenState extends State<doctorChatScreen> {
  @override
  Widget build(BuildContext context) {
    doctorArg = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    color: Colors.grey,
                    iconSize: 35,
                  ),
                ],
              ),
            ),
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        sentTime = DateTime.now();
                        if (messageTextController.text.isEmpty) {
                        } else {
                          _firestore.collection('Messages').add(
                            {
                              'text': messageText,
                              'sender': loggedInDoctorEmail,
                              'time': sentTime,
                              'receiver': doctorArg
                            },
                          );
                          messageTextController.clear();
                        }
                      });
                    },
                    icon: Icon(Icons.send, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Messages')
          .orderBy('time')
          .where("sender", whereIn: ["$loggedInDoctorEmail", "$doctorArg"]).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages!) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final messageTime = message.get('time');
          final messageReceiever = message.get('receiver');

          final currentUser = loggedInDoctorEmail;

          final messageBubble = MessageBubble(
            sender: messageSender,
            receiver: messageReceiever,
            text: messageText,
            time: messageTime,
            isMe: currentUser == messageSender,
          );
            if (messageBubble.sender == loggedInDoctorEmail && messageBubble.receiver == doctorArg || messageBubble.sender == doctorArg && messageBubble.receiver == loggedInDoctorEmail) {

              messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.sender, required this.text, required this.isMe, required this.time, required this.receiver});

  final String sender;
  final String receiver;
  final String text;
  final bool isMe;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? isMeBubbleColor : isNotMeBubbleColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text',
                style:
                    isMe ? TextStyle(fontSize: 16, color: Colors.black) : TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          Text(
            time.toDate().day.toString() +
                "-" +
                time.toDate().month.toString() +
                "  " +
                time.toDate().hour.toString() +
                ":" +
                time.toDate().minute.toString(),
            style: TextStyle(fontSize: 12, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
