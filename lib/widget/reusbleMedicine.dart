// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Medicine.dart';
import 'package:icare/screens/event_details_screen.dart';

import '../services/auth_service.dart';

class reusbleMedicine extends StatefulWidget {
  final Medicine _medicine;

  reusbleMedicine(this._medicine);

  @override
  State<reusbleMedicine> createState() => _reusbleMedicineState();
}

class _reusbleMedicineState extends State<reusbleMedicine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryColor),
        ),
        child: Slidable(
          endActionPane: ActionPane(
              motion: BehindMotion(),
              children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              onPressed: (BuildContext context) {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(AuthService().currentUser!.email)
                      .collection('Medicine')
                      .doc(widget._medicine.medicineName)
                      .delete();
                });
              },
            ),
          ]),
          child: ListTile(
            onTap: () => null,
            //Navigator.of(context).pushNamed(eventDetailsScreen.ID),
            leading: Image.asset("assets/images/tablets/blue_plus.png", height: 40, width: 40),
            title: Text("${widget._medicine.medicineName}"),
            subtitle: Text(
              "${widget._medicine.dosage} Dose per day",
            ),
            trailing: Image.asset("assets/images/tablets/Arrow.png", height: 30, width: 30),
          ),
        ),
      ),
    );
  }
}
