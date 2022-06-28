import 'package:cloud_firestore/cloud_firestore.dart';

class Reports{
  String? glucose;
  String? bloodPressure;
  String? heartRate;
  String? weight;
  String? time;

  Reports();

  Map<String, dynamic> toJson() => {
    'Glucose' : glucose,
    'Blood Pressure': bloodPressure,
    'Heart Rate' : heartRate,
    'Weight' : weight,
    'Measurement Time' : time
  };

  Reports.fromJson(Map<String, dynamic> json){
    glucose = json['Glucose'];
    bloodPressure = json['Blood Pressure'];
    heartRate = json['Heart Rate'];
    weight = json['Weight'];
    time = json['Measurement Time'];
  }

  Reports.fromSnapshot(snapshot)
  : glucose = snapshot.data()['Glucose'],
  bloodPressure = snapshot.data()['Blood Pressure'],
  heartRate = snapshot.data()['Heart Rate'],
  weight = snapshot.data()['Weight'],
  time = snapshot.data()['Measurement Time'];
}