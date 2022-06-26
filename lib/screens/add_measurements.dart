import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/modul/Reports.dart';
import 'package:icare/screens/report_screen.dart';
import 'package:intl/intl.dart';

import '../const/const.dart';
import '../services/auth_service.dart';
import '../widget/reusbleCustomAppbar.dart';

class addMeasurements extends StatefulWidget {
  static const String ID = "AddMeasurementScreen";

  @override
  _addMeasurementsState createState() => _addMeasurementsState();
}

final glucoseController = TextEditingController();
final bloodController = TextEditingController();
final heartRateController = TextEditingController();
final weightController = TextEditingController();

DateTime now = DateTime.now();
String reportTime = now.toString().substring(0, 10);
Reports _reports = Reports();

const measurementMessage = SnackBar(
  content: Text(
      'Measurements added Successfully'
  ),
);

class _addMeasurementsState extends State<addMeasurements> {
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Image.asset("assets/images/measurements.png"),
                              const SizedBox(height: 15),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: primaryColor,
                                    size: 35,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Add New Measurements',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Glucose',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            style: BorderStyle.solid,
                                            color: primaryColor,
                                          ),
                                        ),
                                        hintText: "Mg/dl",
                                        labelText: "Mg/dl",
                                        contentPadding: const EdgeInsets.only(right: 20, left: 20),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: lightTextColor,
                                      ),
                                      controller: glucoseController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Blood Pressure',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            style: BorderStyle.solid,
                                            color: primaryColor,
                                          ),
                                        ),
                                        hintText: "Mg/dl",
                                        labelText: "Mg/dl",
                                        contentPadding: const EdgeInsets.only(right: 20, left: 20),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: lightTextColor,
                                      ),
                                      controller: bloodController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Heart Rate',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            style: BorderStyle.solid,
                                            color: primaryColor,
                                          ),
                                        ),
                                        hintText: "pbm",
                                        labelText: "pbm",
                                        contentPadding: const EdgeInsets.only(right: 20, left: 20),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: lightTextColor,
                                      ),
                                      controller: heartRateController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Weight',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            style: BorderStyle.solid,
                                            color: primaryColor,
                                          ),
                                        ),
                                        hintText: "Kg",
                                        labelText: "Kg",
                                        contentPadding: const EdgeInsets.only(right: 20, left: 20),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: lightTextColor,
                                      ),
                                      controller: weightController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 130,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      primary: primaryColor,
                                    ),
                                    onPressed: () async {
                                      try {
                                        await addMeasur(
                                          glucose: glucoseController.text,
                                          bloodPressure: bloodController.text,
                                          heartRate: heartRateController.text,
                                          weight: weightController.text,
                                          time: reportTime,
                                        );
                                        glucoseController.clear();
                                        bloodController.clear();
                                        heartRateController.clear();
                                        weightController.clear();
                                        Navigator.of(context).pushReplacementNamed(reportScreen.ID);
                                        ScaffoldMessenger.of(context).showSnackBar(measurementMessage);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addMeasur({required String glucose,
    required String bloodPressure,
    required String heartRate,
    required String weight,
    required String time}) async {
    _reports.glucose = glucose;
    _reports.bloodPressure = bloodPressure;
    _reports.heartRate = heartRate;
    _reports.weight = weight;
    _reports.time = time;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Reports')
        .doc(time)
        .set(_reports.toJson());
  }
}
