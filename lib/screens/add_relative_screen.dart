import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/modul/Relatives.dart';
import 'package:icare/widget/reusbleRelative.dart';
import 'package:intl/intl.dart';
import 'package:validation_textformfield/validation_textformfield.dart';

import '../const/const.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class AddRelativeScreen extends StatefulWidget {
  static const String ID = "AddRelativeScreen";

  @override
  _AddRelativeScreenState createState() => _AddRelativeScreenState();
}

final relativeController = TextEditingController();
Relatives _relatives = Relatives();
const addEmailSnackBar = SnackBar(
  content: Text('Relative email added Successfully'),
);
const checkEmailSnackBar = SnackBar(
  content: Text('Please correct email'),
);

class _AddRelativeScreenState extends State<AddRelativeScreen> {
  List<Object> _relativesList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserRelativesList();
  }

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
                            Hero(
                              tag: "appbarImage",
                              child: Image.asset('assets/images/patient.png'),
                            ),
                            Text(
                              'Hello, \n${toBeginningOfSentenceCase(userList[3])!}',
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
              padding: const EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 400),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          child: Text(
                            'Add Relative',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryColor),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _relativesList.isEmpty
                            ? Image.asset(
                                'assets/images/email.png',
                                width: 200,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _relativesList.length,
                                itemBuilder: (context, index) {
                                  getUserRelativesList();
                                  return reusbleRelatives(_relativesList[index] as Relatives);
                                },
                              ),
                        const SizedBox(height: 20),
                        EmailValidationTextField(
                          whenTextFieldEmpty: "Please enter  email",
                          validatorMassage: "Please enter valid email",
                          decoration: InputDecoration(
                            hintText: "Enter Relative Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(style: BorderStyle.solid, color: primaryColor),
                            ),
                            contentPadding: const EdgeInsets.only(right: 20, left: 20),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: lightTextColor,
                          ),
                          textEditingController: relativeController,
                        ),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 48,
                              width: 274,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: primaryColor,
                                ),
                                onPressed: _relativesList.length == 5 || relativeController.text == ""
                                    ? null
                                    : () async {
                                        try {
                                          await createRelative(
                                            relativeEmail: relativeController.text,
                                          );
                                        } catch (e) {
                                          print(e);
                                        }
                                        relativeController.clear();
                                        getUserRelativesList();
                                        ScaffoldMessenger.of(context).showSnackBar(addEmailSnackBar);
                                      },
                                child: const Text(
                                  'Add new Relative',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getUserRelativesList() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Relatives')
        .get();

    setState(() {
      _relativesList = List.from(data.docs.map((collection) => Relatives.fromSnapshot(collection)));
    });
  }

  Future<void> createRelative({
    required String relativeEmail,
  }) async {
    _relatives.relativeEmail = relativeEmail;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Relatives')
        .doc(relativeEmail)
        .set(_relatives.toJson());
  }
}
