// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Appointment.dart';

import '../services/auth_service.dart';

class reusbleAppointment extends StatefulWidget {
  final Appointment _appointment;

  reusbleAppointment(this._appointment);

  @override
  _reusbleAppointmentState createState() => _reusbleAppointmentState();
}

class _reusbleAppointmentState extends State<reusbleAppointment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor),
        ),
        child: ListTile(
          onTap: null,
          leading: Image.asset(
            "assets/images/doctor.jpg",
            height: 55,
            width: 55,
            fit: BoxFit.cover,
          ),
          title: Text("Dr\. ${widget._appointment.doctorName}"),
          subtitle: Text("${widget._appointment.day}, ${widget._appointment.time}"),
          trailing: Wrap(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check_circle),
                color: primaryColor,
                iconSize: 35,
                onPressed: () async {
                  try {
                    await approvedAppointment(
                        appointmentDay: widget._appointment.day!,
                        appointmentTime: widget._appointment.time!,
                        doctorName: widget._appointment.doctorName!);
                    deleteAppointment();
                  } catch (e) {
                    print(e);
                  }
                },
              ), // icon-1
              IconButton(
                icon: Icon(Icons.cancel),
                color: Colors.red,
                iconSize: 35,
                onPressed: () {
                  setState(() {
                    deleteAppointment();
                  });
                },
              ), // icon-2
            ],
          ),
        ),
      ),
    );
  }

  Future<void> approvedAppointment(
      {required String doctorName, required String appointmentDay, required String appointmentTime}) async {
    widget._appointment.doctorName = doctorName;
    widget._appointment.day = appointmentDay;
    widget._appointment.time = appointmentTime;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Approved Appointment')
        .doc(doctorName)
        .set(widget._appointment.toJson());
  }

  Future<void> deleteAppointment() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthService().currentUser!.email)
        .collection('Appointment')
        .doc(widget._appointment.doctorName)
        .delete();
  }
}
