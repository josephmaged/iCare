import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icare/const/const.dart';
import 'package:icare/modul/Relatives.dart';

import '../services/auth_service.dart';

class reusbleRelatives extends StatefulWidget {
  final Relatives _relatives;

  reusbleRelatives(this._relatives);

  @override
  _reusbleRelativesState createState() => _reusbleRelativesState();
}

class _reusbleRelativesState extends State<reusbleRelatives> {
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
                          .collection('Relatives')
                          .doc(widget._relatives.relativeEmail)
                          .delete();
                    });
                  },
                ),
              ]),
          child: ListTile(
            title: Text(
              widget._relatives.relativeEmail.toString()
            ),
          ),
        ),
      ),
    );
  }
}

