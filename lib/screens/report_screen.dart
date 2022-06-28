import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:icare/modul/Relatives.dart';
import 'package:icare/modul/Reports.dart';
import 'package:icare/screens/add_measurements.dart';
import 'package:icare/widget/reusbleReport.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/const.dart';
import '../modul/Reports.dart';
import '../services/auth_service.dart';
import '../widget/reusbleCustomAppbar.dart';

class reportScreen extends StatefulWidget {
  static const String ID = "ReportScreen";

  @override
  _reportScreenState createState() => _reportScreenState();
}

DateTime now = DateTime.now();
var selectedDate = now.toString().substring(0, 10);

class _reportScreenState extends State<reportScreen> {
  List<Reports> _reportList = [];
  List<Relatives> _relativeList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserReportList();
    getUserRelativeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: primaryColor,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: const [
                    ReusbleCustomAppbar(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100,
                              child: AnimatedHorizontalCalendar(
                                date: DateTime.now(),
                                tableCalenderIcon: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                                tableCalenderButtonColor: secondaryColor,
                                selectedColor: const Color(0XFFF5CBC3),
                                onDateSelected: (date) {
                                  setState(() {
                                    selectedDate = date;
                                    getUserReportList();
                                  });
                                },
                              ),
                            ),
                            Column(
                              children: [
                                _reportList.isEmpty
                                    ? Image.asset(
                                  'assets/images/no_data.png',
                                  width: 200,
                                )
                                    : reusbleReport(_reportList[0] as Reports),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      primary: primaryColor,
                                    ),
                                    onPressed: () => Navigator.of(context).pushReplacementNamed(addMeasurements.ID),
                                    child: const Text(
                                      'Add new Measurements',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      primary: primaryColor,
                                    ),
                                    onPressed: () async {
                                      List<String> emails = [];
                                      for (Relatives relative in _relativeList) {
                                        emails.add(relative.relativeEmail!);
                                      }
                                      print(emails.length);
                                      print(_relativeList.length);
                                      final Email email = Email(
                                        body:
                                        ("Report for day $selectedDate is : \nGlucose: ${_reportList[0]
                                            .glucose} \nBlood Pressure: ${_reportList[0]
                                            .bloodPressure} \nHeart Rate: ${_reportList[0]
                                            .heartRate} \nWeight: ${_reportList[0].weight}"),
                                        subject: 'Patient Report',
                                        recipients: emails,
                                      );
                                      await FlutterEmailSender.send(email);
                                    },
                                    child: const Text(
                                      'Send',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getUserReportList() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Reports')
        .where('Measurement Time', isEqualTo: selectedDate)
        .get();

    setState(() {
      _reportList = data.docs.map<Reports>((collection) => Reports.fromSnapshot(collection)).toList();
    });
  }

  Future getUserRelativeList() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Relatives')
        .get();

    setState(() {
      _relativeList = data.docs.map<Relatives>((collection) => Relatives.fromSnapshot(collection)).toList();
    });
  }
}
