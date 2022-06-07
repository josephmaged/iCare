// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:icare/modul/Medicine.dart';
import 'package:icare/services/DataBaseManager.dart';
import 'package:icare/screens/medicine_schedule_screen.dart';
import 'package:icare/screens/user_profile_screen.dart';
import 'package:icare/widget/reusbleCustomAppbar.dart';
import 'package:icare/services/auth_service.dart';

class addMedicineScreen extends StatefulWidget {
  static const String ID = "AddMedicineScreen";

  @override
  _addMedicineScreenState createState() => _addMedicineScreenState();
}


String reminderTimesDropDown = 'Once';
Frequency? selectedFrequency;

String durationDropDown = '2 Months';

//picker
TimeOfDay selectedStartTime = TimeOfDay.now();
TimeOfDay selectedEndTime = TimeOfDay.now();
DateTime startDate = DateTime.now().toLocal();
DateTime endDate = DateTime.now().toLocal();

// Get medicine name
final medicineController = TextEditingController();

class _addMedicineScreenState extends State<addMedicineScreen> {
  // Dosage numbers
  int dosage = 1;

  void increase() {
    if (dosage < 6) {
      dosage += 1;
    }
  }

  void decrease() {
    if (dosage > 1) {
      dosage -= 1;
    }
  }

  // Event Comments

  // Add to calender
  Event addEvent({Recurrence? recurrence}) {
    return Event(
      title: medicineController.text,
      startDate:
          DateTime(startDate.year, startDate.month, startDate.day, selectedStartTime.hour, selectedStartTime.minute),
      endDate:
      DateTime(startDate.year, startDate.month, startDate.day, selectedStartTime.hour, selectedStartTime.minute),
      recurrence: Recurrence(
        frequency: selectedFrequency,
        endDate: DateTime(endDate.year, endDate.month, endDate.day, selectedEndTime.hour, selectedEndTime.minute),
      ),
      description: 'Number of doses \'per day\' $dosage',
    );
  }

  // Add medicine data
  String dataStartDate = DateTime(startDate.year, startDate.month, startDate.day, selectedStartTime.hour, selectedStartTime.minute).toString();
  String dataEndDate = DateTime(endDate.year, endDate.month, endDate.day, selectedEndTime.hour, selectedEndTime.minute).toString();

  // Clear controller
  clearTextInput(){
    medicineController.clear();
    selectedStartTime = TimeOfDay.now();
    selectedEndTime = TimeOfDay.now();
    startDate = DateTime.now().toLocal();
    endDate = DateTime.now().toLocal();
  }

  Medicine _medicine = Medicine();

  @override
  void initState() {
    clearTextInput();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    ReusbleCustomAppbar(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 80),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Add new medicine',
                                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset('assets/images/tablets.png', scale: 1)
                                ],
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Medicine Name',
                                  suffixIcon: IconButton(
                                    onPressed: medicineController.clear,
                                    icon: Icon(Icons.clear),
                                  ),
                                ),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                                controller: medicineController,
                              ),
                              SizedBox(height: 20),
                              /*Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Reminder times',
                                    style: TextStyle(color: Color(0XFF49505A), fontSize: 20),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: Color(0XFFC4C4C4))),
                                    child: DropdownButtonHideUnderline(
                                      child: Center(
                                        child: DropdownButton(
                                          value: reminderTimesDropDown,
                                          elevation: 16,
                                          style: TextStyle(
                                            color: Color(0XFF867E7E),
                                          ),
                                          icon: Icon(
                                            Icons.arrow_drop_down_circle,
                                            color: Color(0XFF19417C),
                                            size: 30,
                                          ),
                                          items:
                                              ["Once", "Daily", "Weekly"].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              reminderTimesDropDown = newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),*/
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dosage (per day)',
                                    style: TextStyle(color: darkTextColor, fontSize: 20),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: primaryColor)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              decrease();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: primaryColor,
                                            size: 30,
                                          ),
                                        ),
                                        Text(
                                          '$dosage',
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              increase();
                                            });
                                          },
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: primaryColor,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Start',
                                    style: TextStyle(color: darkTextColor, fontSize: 20),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 260,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: primaryColor)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            _startDate(context);
                                          },
                                          child: Text(
                                            "$startDate".split(' ')[0],
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _selectStartTime(context);
                                          },
                                          child: Text(
                                            "${selectedStartTime.hour} : ${selectedStartTime.minute}",
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold, color: Color(0XFF867E7E)),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _startDate(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down_circle,
                                            color: primaryColor,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'End',
                                    style: TextStyle(color: darkTextColor, fontSize: 20),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 260,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: primaryColor)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            _endDate(context);
                                          },
                                          child: Text(
                                            "$endDate".split(' ')[0],
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold, color: lightTextColor),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _selectEndTime(context);
                                          },
                                          child: Text(
                                            "${selectedEndTime.hour} : ${selectedEndTime.minute}",
                                            style: TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold, color: Color(0XFF867E7E)),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _endDate(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_drop_down_circle,
                                            color: primaryColor,
                                            size: 30,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Repeat',
                                    style: TextStyle(color: darkTextColor, fontSize: 20),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: primaryColor)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        DropdownButtonHideUnderline(
                                          child: Center(
                                            child: DropdownButton<Frequency>(
                                              hint: Text('Select frequency'),
                                              value: selectedFrequency,
                                              elevation: 16,
                                              style: TextStyle(
                                                color: lightTextColor,
                                              ),
                                              icon: Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: primaryColor,
                                                size: 30,
                                              ),
                                              items: Frequency.values.map((selectedFrequency) {
                                                return DropdownMenuItem<Frequency>(
                                                  value: selectedFrequency,
                                                  child: Text(
                                                    selectedFrequency.name,
                                                    style: TextStyle(
                                                        color: lightTextColor,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedFrequency = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                height: 48,
                                width: 274,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    primary: secondaryColor,
                                  ),
                                  onPressed: () async {
                                    Add2Calendar.addEvent2Cal(addEvent());
                                    await createMedicine(
                                        medicineName: medicineController.text,
                                        dosage: dosage.toString(),
                                        start: dataStartDate,
                                        end: dataEndDate,
                                        repeat: selectedFrequency!.name.toString());

                                    Navigator.pushReplacement(
                                      context,
                                        MaterialPageRoute(builder: (BuildContext context) => scheduleScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Add Schedule',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: darkTextColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedStartTime) {
      setState(() {
        selectedStartTime = timeOfDay;
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedEndTime) {
      setState(() {
        selectedEndTime = timeOfDay;
      });
    }
  }

  _startDate(BuildContext context) async {
    final DateTime? dateOfDay = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (dateOfDay != null && dateOfDay != startDate) {
      setState(() {
        startDate = dateOfDay;
      });
    }
  }

  _endDate(BuildContext context) async {
    final DateTime? dateOfDay = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (dateOfDay != null && dateOfDay != endDate) {
      setState(() {
        endDate = dateOfDay;
      });
    }
  }

  Future<void> createMedicine(
      {required String medicineName, required String dosage, required String start, required String end, required String repeat}) async {


    _medicine.medicineName = medicineName;
    _medicine.dosage = dosage;
    _medicine.start = start;
    _medicine.end = end;
    _medicine.repeat = repeat;

    await FirebaseFirestore.instance.collection('Users').doc(AuthService().currentUser!.email).collection('Medicine').doc(medicineName).set(
      _medicine.toJson()
    );
  }
}
