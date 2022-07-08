import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Users.dart';
import 'package:icare/services/auth_service.dart';
import 'package:icare/widget/reusbleChat.dart';

class chatWithDoctorScreen extends StatefulWidget {
  static const String ID = "ChatWithDoctorScreen";

  @override
  _chatWithDoctorScreenState createState() => _chatWithDoctorScreenState();
}

class _chatWithDoctorScreenState extends State<chatWithDoctorScreen> {
  List<Object> _userList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.grey,
                        iconSize: 35,
                      ),
                      const Text(
                        'Chats',
                        style: TextStyle(color: primaryColor, fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.segment),
                        color: Colors.grey,
                        iconSize: 35,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: FirestoreSearchBar(
                      tag: 'ChatSearsh',
                      clearSearchButtonColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: FirestoreSearchResults.builder(
                      tag: 'ChatSearsh',
                      firestoreCollectionName: 'Users',
                      searchBy: 'First Name',
                      initialBody: ListView.builder(
                        itemCount: _userList.length,
                        itemBuilder: (context, index) {
                          return reusbleChat(_userList[index] as Users);
                        },
                      ),
                      dataListFromSnapshot: Users().dataListFromSnapshot,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<Users>? dataList = snapshot.data;
                          if (dataList!.isEmpty) {
                            return const Center(
                              child: Text('No Results Found'),
                            );
                          }
                          return ListView.builder(
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return reusbleChat(dataList[index]);
                            },
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('No Results Found'),
                            );
                          }
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getUsersList() async {
    var userData = await FirebaseFirestore.instance.collection('Users').where('Rule ID', isEqualTo: "true").get();

    setState(() {
      _userList = List.from(userData.docs.map((collection) => Users.fromSnapshot(collection)));
    });
  }
}
