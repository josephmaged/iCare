import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/modul/Reports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/const.dart';

class reusbleReport extends StatefulWidget {
  final Reports _reports;

  reusbleReport(this._reports);

  @override
  _reusbleReportState createState() => _reusbleReportState();
}

class _reusbleReportState extends State<reusbleReport> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 15,right: 15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Glucose',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget._reports.glucose} Mg/dl',
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 15,right: 15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Blood Pressure',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget._reports.bloodPressure} Mg/dl',
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 15,right: 15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Heart Rate',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget._reports.heartRate} pbm',
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 15,right: 15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weight',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget._reports.weight} Kg',
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ],
          ),
        )
      ],
    );
  }
}
