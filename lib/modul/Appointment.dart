class Appointment {
  String? doctorName;
  String? day;
  String? time;

  Appointment();

  Map<String, dynamic> toJson() => {
    'Doctor Name' : doctorName,
    'Appointment Day' : day,
    'Appointment Time' : time
  };

  Appointment.fromSnapshot(snapshot)
  : doctorName = snapshot.data()['Doctor Name'],
  day = snapshot.data()['Appointment Day'],
  time = snapshot.data()['Appointment Time'];
}