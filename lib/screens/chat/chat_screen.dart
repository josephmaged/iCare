import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icare/const/const.dart';
import 'package:icare/doctor/chat/doctor_chat_screen.dart';
import 'package:icare/modul/Users.dart';
import 'package:icare/screens/home_screen.dart';
import 'package:icare/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

final _firestore = FirebaseFirestore.instance;

class chatScreen extends StatefulWidget {
  static const String ID = "ChatScreen";

  const chatScreen({Key? key}) : super(key: key);

  @override
  _chatScreenState createState() => _chatScreenState();
}

final messageTextController = TextEditingController();
DateTime sentTime = DateTime.now();
late String messageText;

var userArg;

class _chatScreenState extends State<chatScreen> {
  @override
  Widget build(BuildContext context) {
    userArg = ModalRoute.of(context)!.settings.arguments;

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
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.grey,
                    iconSize: 35,
                  ),
                ],
              ),
            ),
            const MessageStream(),
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
                            {'text': messageText, 'sender': loggedInUserEmail, 'time': sentTime, 'receiver': userArg},
                          );
                          messageTextController.clear();
                        }
                      });
                    },
                    icon: const Icon(Icons.send, size: 30),
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
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Messages')
          .orderBy('time')
          .where("sender", whereIn: ["$loggedInUserEmail", "$userArg"]).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
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
          final messageReceiver = message.get('receiver');
          final messageTime = message.get('time');

          final currentUser = loggedInUserEmail;
          //if (currentUser == messageSender) {}

          final messageBubble = MessageBubble(
            sender: messageSender,
            receiver: messageReceiver,
            text: messageText,
            time: messageTime,
            isMe: currentUser == messageSender,
          );
          if (messageBubble.sender == loggedInUserEmail && messageBubble.receiver == userArg ||
              messageBubble.sender == userArg && messageBubble.receiver == loggedInUserEmail) {
            messageBubbles.add(messageBubble);
            if (kDebugMode) {
              print(messageBubble.receiver);
            }
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, required this.sender, required this.text, required this.isMe, required this.time, required this.receiver}) : super(key: key);

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
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? isMeBubbleColor : isNotMeBubbleColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: isMe
                    ? const TextStyle(fontSize: 16, color: Colors.black)
                    : const TextStyle(fontSize: 16, color: Colors.black),
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
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
