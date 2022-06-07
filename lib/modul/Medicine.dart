class Medicine {
  String? dosage;
  String? end;
  String? start;
  String? repeat;
  String? medicineName;

  Medicine ();

  Map<String, dynamic> toJson() => {

    'Medicine Name' : medicineName,
    'Dosage': dosage,
    'End': end,
    'Start': start,
    'Repeat': repeat,
  };

  Medicine.fromSnapshot(snapshot)
  : medicineName = snapshot.data()['Medicine Name'],
  dosage = snapshot.data()['Dosage'],
  end = snapshot.data()['End'],
  start = snapshot.data()['Start'],
  repeat = snapshot.data()['Repeat'];
}