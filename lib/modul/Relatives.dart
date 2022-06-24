class Relatives {
  String? relativeEmail;

  Relatives();

  Map<String, String?> toJson() => {
    'Relative Email' : relativeEmail
  };

  Relatives.fromSnapshot(snapshot)
  : relativeEmail = snapshot.data()['Relative Email'];
}