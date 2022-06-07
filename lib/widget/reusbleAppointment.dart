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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: primaryColor)),
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
                onPressed: () {},
              ), // icon-1
              IconButton(
                icon: Icon(Icons.cancel),
                color: Colors.red,
                iconSize: 35,
                onPressed: () {
                  setState(() {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(AuthService().currentUser!.email)
                        .collection('Appointment')
                        .doc(widget._appointment.doctorName)
                        .delete();
                  });
                },
              ), // icon-2
            ],
          ),
        ),
      ),
    );
  }
}
