// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icare/modul/Medicine.dart';

import 'auth_service.dart';

class DataBaseManager {

  final CollectionReference userData = FirebaseFirestore.instance.collection('Users');

  Future<void> createUserData({required String ruleID, required String firstname, required String lastname, required String email}) async {
    return await userData.doc(email).set({
      'Rule ID': ruleID,
      'First Name': firstname,
      'Last Name': lastname
    });
  }

  Future getUserData({required String email}) async {
    final DocumentReference<Map<String, dynamic>> userDataEmail = FirebaseFirestore.instance.collection('Users').doc(
        email);

    List userList = [];
    try {
      await userDataEmail.get().then((querySnapshot) {
        querySnapshot.data()!.forEach((dataKey, value) {
          userList.add(value);
        });
      });
      return userList;
    } catch (e) {
      print(e.toString());
    }
  }

}
