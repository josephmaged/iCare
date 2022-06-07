
import 'package:flutter/material.dart';
import 'package:icare/modul/Comments.dart';
import 'package:icare/screens/post_comments_screen.dart';


class ReusbleComment extends StatelessWidget {
  final Comments _comments;
  ReusbleComment(this._comments);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _comments.senderName!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0XFFF5F5F5), borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  _comments.comment!,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
