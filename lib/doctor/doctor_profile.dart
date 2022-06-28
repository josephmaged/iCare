import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/doctor/doctor_home.dart';
import 'package:intl/intl.dart';

import '../const/const.dart';
import '../modul/Users.dart';
import '../services/DataBaseManager.dart';

enum Gender { Male, Female }

String? selectedMajor;

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Allergy and Anesthesiology"), value: "Allergy and Anesthesiology"),
    const DropdownMenuItem(child: Text("Dermatology"), value: "Dermatology"),
    const DropdownMenuItem(child: Text("Internal medicine"), value: "Internal medicine"),
    const DropdownMenuItem(child: Text("Neurology"), value: "Neurology"),
    const DropdownMenuItem(child: Text("Obstetrics and gynecology"), value: "Obstetrics and gynecology"),
    const DropdownMenuItem(child: Text("Ophthalmology"), value: "Ophthalmology"),
    const DropdownMenuItem(child: Text("Pathology"), value: "Pathology"),
    const DropdownMenuItem(child: Text("Pediatrics"), value: "Pediatrics"),
    const DropdownMenuItem(child: Text("Psychiatry"), value: "Psychiatry"),
    const DropdownMenuItem(child: Text("Radiation"), value: "Radiation"),
    const DropdownMenuItem(child: Text("oncology"), value: "oncology"),
    const DropdownMenuItem(child: Text("Surgery"), value: "Surgery"),
    const DropdownMenuItem(child: Text("Urology"), value: "Urology"),
  ];
  return menuItems;
}

class DoctorProfile extends StatefulWidget {
  static const String ID = "DoctorProfileScreen";

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Gender? _gender = Gender.Male;

  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();
  final clinicAddrController = TextEditingController();
  final aboutController = TextEditingController();

  var dateFormat = DateFormat('dd-MM-yyyy');
  DateTime birthDate = DateTime(2010);


  @override
  void initState() {
    super.initState();
  }

/*
  Future<void> createUser(
      {required String docMajor,
      required String docGender,
      required String docBirthday,
      required String docPhone,
      required String clinicAddress,
      required String aboutDoc}) async {
    _users.docMajor = docMajor;
    _users.ruleID = 'true';
    _users.firstName = _users.firstName;
    _users.lastName = _users.lastName;
    _users.gender = docGender;
    _users.birthday = docBirthday;
    _users.phone = docPhone;
    _users.clinicAddress = clinicAddress;
    _users.aboutDoc = aboutDoc;

    await FirebaseFirestore.instance.collection('Users').doc(_users.userEmail).set(_users.toJson());
  }*/
  /*
  fetchDatabaseList() async {
    dynamic resultdata = await DataBaseManager().getUserData(email: loggedInDoctorEmail);
    if (resultdata == null) {
      print("enable to get ");
    } else {
      setState(() {
        userList = resultdata;
      });
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.grey,
                          iconSize: 35,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/doctorProfile.png'),
                            Text(
                              'Hello \nDR. ${toBeginningOfSentenceCase(docData['First Name'])}',
                              style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 380),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Major',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), border: Border.all(color: primaryColor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: const Text('Select Major'),
                              value: selectedMajor,
                              elevation: 16,
                              style: const TextStyle(
                                color: lightTextColor,
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: primaryColor,
                                size: 30,
                              ),
                              items: dropdownItems,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMajor = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Gender',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: darkTextColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 160,
                              child: RadioListTile(
                                title: const Text(
                                  'Male',
                                  style: TextStyle(color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                value: Gender.Male,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                                groupValue: _gender,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 160,
                              child: RadioListTile(
                                title: const Text(
                                  'Female',
                                  style: TextStyle(color: lightTextColor, fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                value: Gender.Female,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                                groupValue: _gender,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'BirthDate',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                            ),
                            Container(
                              height: 40,
                              width: 180,
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), border: Border.all(color: primaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _birthDate(context);
                                    },
                                    child: Text(
                                      "$birthDate".split(' ')[0],
                                      style: const TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: primaryColor,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Contact',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Phone',
                              hintStyle: TextStyle(color: lightTextColor)),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                          controller: phoneNumController,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Clinic Address',
                              hintStyle: TextStyle(color: lightTextColor)),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                          controller: clinicAddrController,
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'About',
                              hintStyle: TextStyle(color: lightTextColor)),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                          controller: aboutController,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            height: 48,
                            width: 274,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                primary: secondaryColor,
                              ),
                              onPressed: () async {
                                if (selectedMajor == null ||
                                    phoneNumController.text.isEmpty ||
                                    clinicAddrController.text.isEmpty ||
                                    aboutController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(content: Text('Please fill empty fields')));
                                } else {
                                  final editDoc = FirebaseFirestore.instance.collection('Users').doc(loggedInDoctorEmail);
                                  editDoc.update({
                                    'Doctor Major': selectedMajor.toString(),
                                    'Gender': _gender!.name,
                                    'Birthday': dateFormat.format(birthDate),
                                    'Phone': phoneNumController.text,
                                    'Clinic Address': clinicAddrController.text,
                                    'About Doctor': aboutController.text,
                                  });
                                  Navigator.of(context).pushReplacementNamed(doctorHomeScreen.ID);
                                }
                              },
                              child: const Text(
                                'Edit profile',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: darkTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _birthDate(BuildContext context) async {
    final DateTime? dayOfBirth = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2010),
    );
    if (dayOfBirth != null && dayOfBirth != birthDate) {
      setState(() {
        birthDate = dayOfBirth;
        birthDate.toLocal();
      });
    }
  }
}
