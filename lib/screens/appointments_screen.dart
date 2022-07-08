import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Appointment.dart';
import 'package:icare/screens/add_appointments_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:icare/widget/reusbleAppointment.dart';
import 'package:icare/widget/reusbleCustomAppbar.dart';

import '../services/auth_service.dart';

class appointmentScreen extends StatefulWidget {
  static const String ID = "AppointmentsScreen";

  @override
  _appointmentScreenState createState() => _appointmentScreenState();
}

class _appointmentScreenState extends State<appointmentScreen> {
  List<Object> _appointmentList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserAppointmentList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 100;

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
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Hero(
                                  tag: 'appointments',
                                  child: Icon(
                                    Icons.check_circle,
                                    color: primaryColor,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width: screenWidth,
                                  child: const Text(
                                    'Check up your upcoming appointments.',
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: _appointmentList.isEmpty
                                  ? Image.asset(
                                      'assets/images/no_data.png',
                                      width: 200,
                                    )
                                  : ListView.builder(
                                      itemCount: _appointmentList.length,
                                      itemBuilder: (context, index) {
                                        getUserAppointmentList();
                                        return reusbleAppointment(_appointmentList[index] as Appointment);
                                      }),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 48,
                                  width: 274,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                      primary: secondaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (BuildContext context) => addAppointmentsScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'Add new Appointment',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: darkTextColor,
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getUserAppointmentList() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Appointment')
        .orderBy('Appointment Day', descending: true)
        .get();

    if (!mounted) return;

    setState(() {
      _appointmentList = List.from(data.docs.map((collection) => Appointment.fromSnapshot(collection)));
    });
  }
}
