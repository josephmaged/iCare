import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  String? post;
  String? senderEmail;
  String? senderName;
  Timestamp? time;

  Posts();

  Map<String, dynamic> toJason() =>
      {'post': post, 'sender email': senderEmail, 'sender name': senderName, 'time': time};

  Posts.fromSnapshot(snapshot)
  : post = snapshot.data()['post'],
  senderName = snapshot.data()['sender name'],
  senderEmail = snapshot.data()['sender email'],
  time = snapshot.data()['time'];
}
