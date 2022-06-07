import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  String? comment;
  String? senderEmail;
  String? senderName;
  Timestamp? time;

  Comments();

  Map<String, dynamic> toJason() =>
      {'comment': comment, 'sender email': senderEmail, 'sender name': senderName, 'time': time};

  Comments.fromSnapshot(snapshot)
      : comment = snapshot.data()['comment'],
        senderName = snapshot.data()['sender name'],
        senderEmail = snapshot.data()['sender email'],
        time = snapshot.data()['time'];
}
