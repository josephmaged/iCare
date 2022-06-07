import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? firstName;
  String? lastName;
  String? ruleID;
  String? userEmail;
  String? docMajor;
  String? gender;
  String? birthday;
  String? phone;
  String? clinicAddress;
  String? aboutDoc;

  Users(
      {this.firstName,
      this.lastName,
      this.userEmail,
      this.ruleID,
      this.docMajor,
      this.gender,
      this.birthday,
      this.phone,
      this.clinicAddress,
      this.aboutDoc});

  Map<String, dynamic> toJson() => {
        'First Name': firstName,
        'Last Name': lastName,
        'Rule ID': ruleID,
        'User Email': userEmail,
        'Doctor Major': docMajor,
        'Gender': gender,
        'Birthday': birthday,
        'Phone': phone,
        'Clinic Address': clinicAddress,
        'About Doctor': aboutDoc
      };

  Users.fromSnapshot(snapshot)
      : firstName = snapshot.data()['First Name'],
        lastName = snapshot.data()['Last Name'],
        ruleID = snapshot.data()['Rule ID'],
        userEmail = snapshot.data()['User Email'],
        docMajor = snapshot.data()['Doctor Major'];

  List<Users> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((snapshot) {
          final Map<String, dynamic> dataMap = snapshot.data() as Map<String, dynamic>;
          return Users(
              firstName: dataMap['First Name'],
              lastName: dataMap['Last Name'],
              ruleID: dataMap['Rule ID'],
              userEmail: dataMap['User Email'],
              docMajor: dataMap['Doctor Major']);
        })
        .where((element) => element.ruleID == 'true')
        .toList();
  }
}
