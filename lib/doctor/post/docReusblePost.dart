
import 'package:flutter/material.dart';
import 'package:icare/doctor/post/doc_post_comments_screen.dart';
import 'package:icare/modul/Posts.dart';


class DocReusblePost extends StatelessWidget {
  final Posts _posts;
  const DocReusblePost(this._posts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const docPostCommentsScreen(),
              settings: RouteSettings(arguments: _posts)
          ),
        ),
      },
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _posts.senderName!,
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
                    _posts.post!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.comment_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Add Comment',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.add_circle,
                      color: Colors.grey,
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
}
