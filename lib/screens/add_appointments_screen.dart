import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:icare/modul/Appointment.dart';
import 'package:icare/screens/appointments_screen.dart';

import '../const/const.dart';
import '../services/auth_service.dart';
import '../widget/reusbleCustomAppbar.dart';

class addAppointmentsScreen extends StatefulWidget {
  static const String ID = "AddAppointmentsScreen";

  @override
  _addAppointmentsScreenState createState() => _addAppointmentsScreenState();
}

enum WeekDays { Sunday, Monday, Tuesday, Wednesday, Thursday, Friday }

WeekDays? SelectedDay;
TimeOfDay selectedTime = TimeOfDay.now();
final doctorController = TextEditingController();
Appointment _appointment = Appointment();

class _addAppointmentsScreenState extends State<addAppointmentsScreen> {
  @override
  void initState() {
    clearTextInput();
    super.initState();
  }

  // Clear controller
  clearTextInput() {
    doctorController.clear();
    selectedTime = TimeOfDay.now();
    SelectedDay = WeekDays.Sunday;
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
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
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
                              const SizedBox(height: 15),
                              Image.asset('assets/images/calender.png'),
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
                                    'Add New Appointment',
                                    style: TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Dr Name',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: const BorderSide(style: BorderStyle.solid, color: primaryColor),
                                    ),
                                    contentPadding: const EdgeInsets.only(right: 20, left: 20),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: lightTextColor,
                                  ),
                                  controller: doctorController,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Day',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(style: BorderStyle.solid, color: primaryColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20, left: 20),
                                    child: DropdownButton<WeekDays>(
                                      hint: const Text('Select Day'),
                                      value: SelectedDay,
                                      elevation: 16,
                                      style: const TextStyle(
                                        color: lightTextColor,
                                      ),
                                      icon: const Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                      items: WeekDays.values.map((SelectedDay) {
                                        return DropdownMenuItem<WeekDays>(
                                          value: SelectedDay,
                                          child: Text(
                                            SelectedDay.name,
                                            style: const TextStyle(
                                              color: lightTextColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          SelectedDay = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Time',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(style: BorderStyle.solid, color: primaryColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                ),
                                padding: const EdgeInsets.only(right: 20, left: 20),
                                child: TextButton(
                                  onPressed: () {
                                    _selectTime(context);
                                  },
                                  child: SizedBox(
                                    height: 20,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${selectedTime.hour} : ${selectedTime.minute}  ${selectedTime.period.name}",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0XFF867E7E),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 48,
                                width: 274,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    primary: secondaryColor,
                                  ),
                                  onPressed: () async {
                                    try {
                                      await createAppointment(
                                        doctorName: doctorController.text,
                                        appointmentDay: SelectedDay!.name.toString(),
                                        appointmentTime: selectedTime.format(context),
                                      );
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print(e);
                                      }
                                    }
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => appointmentScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Add Appointment',
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  Future<void> createAppointment(
      {required String doctorName, required String appointmentDay, required String appointmentTime}) async {
    _appointment.doctorName = doctorName;
    _appointment.day = appointmentDay;
    _appointment.time = appointmentTime;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Appointment')
        .doc(doctorName)
        .set(_appointment.toJson());
  }
}
