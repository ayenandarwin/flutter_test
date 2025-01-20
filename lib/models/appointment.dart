class Appointment {
  int? id;
  String title;
  String customerName;
  String company;
  String description;
  DateTime dateTime;
  double latitude;
  double longitude;

  Appointment({
    this.id,
    required this.title,
    required this.customerName,
    required this.company,
    required this.description,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'customerName': customerName,
      'company': company,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'],
      customerName: map['customerName'],
      company: map['company'],
      description: map['description'],
      dateTime: DateTime.parse(map['dateTime']),
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}