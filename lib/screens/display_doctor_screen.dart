import 'package:flutter/material.dart';
import 'package:icare/modul/Users.dart';
import 'package:intl/intl.dart';

import '../const/const.dart';

class DisplayDoctorScreen extends StatefulWidget {
  static const String ID = "DisplayDoctorScreen";

  final Users _users;
  DisplayDoctorScreen(this._users);

  @override
  _DisplayDoctorScreenState createState() => _DisplayDoctorScreenState();
}

List displayDoctorList = [];

class _DisplayDoctorScreenState extends State<DisplayDoctorScreen> {


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
                              'DR. ${toBeginningOfSentenceCase(widget._users.firstName)}',
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
                  margin: const EdgeInsets.only(top: 400),
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
                        Text(
                          '${toBeginningOfSentenceCase(widget._users.docMajor)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Gender',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${toBeginningOfSentenceCase(widget._users.gender)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'BirthDate',
                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget._users.birthday}',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Contact',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: primaryColor),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Phone',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                         ' ${widget._users.phone}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Clinic Address',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ' ${widget._users.clinicAddress}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'About Doctor',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ' ${widget._users.aboutDoc}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
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
}
