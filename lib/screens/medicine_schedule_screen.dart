import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Medicine.dart';
import 'package:icare/screens/add_medicine_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:icare/services/DataBaseManager.dart';
import 'package:icare/services/auth_service.dart';
import 'package:icare/widget/reusbleCustomAppbar.dart';
import 'package:icare/widget/reusbleMedicine.dart';

class scheduleScreen extends StatefulWidget {
  static const String ID = "ScheduleScreen";

  @override
  _scheduleScreenState createState() => _scheduleScreenState();
}

class _scheduleScreenState extends State<scheduleScreen> {
  List<Object> _medicineList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserMedicineList();
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
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 49,
                                  width: 174,
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: secondaryColor,
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.schedule,
                                        color: primaryColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Schedule',
                                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset('assets/images/scheduleTablets.png', scale: 1.5)
                              ],
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: _medicineList.isEmpty
                                  ? Image.asset(
                                      'assets/images/no_data.png',
                                      width: 200,
                                    )
                                  : ListView.builder(
                                      itemCount: _medicineList.length,
                                      itemBuilder: (context, index) {
                                        getUserMedicineList();
                                        return reusbleMedicine(_medicineList[index] as Medicine);
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
                                        MaterialPageRoute(builder: (BuildContext context) => addMedicineScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'Add new medicine',
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getUserMedicineList() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Medicine')
        .orderBy('Start', descending: true)
        .get();

    setState(() {
      _medicineList = List.from(data.docs.map((collection) => Medicine.fromSnapshot(collection)));
    });
  }
}
