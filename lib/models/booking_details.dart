import 'dart:convert';

class BookingDetails {
  BookingDetails({
    required this.id,
    required this.startdate,
    required this.enddate,
    required this.starttime,
    required this.endtime,
    required this.title,
    required this.description,
    required this.visibility,
    required this.participants,
    required this.priority,
    required this.notify,
    required this.color,
  });

  final String id;
  final String startdate;
  final String enddate;
  final String starttime;
  final String endtime;
  final String title;
  final String description;
  final String visibility;
  final String participants;
  final String priority;
  final String notify;
  final String color;

// creating map of above variables
  Map<String, dynamic> toMap() {
    return {
      'startdate': startdate,
      'enddate': enddate,
      'starttime': starttime,
      'endtime': endtime,
      'title': title,
      'description': description,
      'visibility': visibility,
      'participants': participants,
      'priority': priority,
      'notify': notify,
      'color': color
    };
  }

// from above map we are putting variables into new UserDetails object. Mutating initial object
  factory BookingDetails.fromMap(Map<String, dynamic> map) {
    return BookingDetails(
        id: map['_id'] ?? '',
        startdate: map['startdate'] ?? '',
        enddate: map['enddate'] ?? '',
        starttime: map['starttime'] ?? '',
        endtime: map['endtime'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        visibility: map['visibility'] ?? '',
        participants: map['participants'] ?? '',
        priority: map['priority'] ?? '',
        notify: map['notify'] ?? '',
        color: map['color'] ?? '');
  }

// encoding map to json
  String toJson() => json.encode(toMap());

// getting UserDetails object itself
  factory BookingDetails.fromJson(json) {
    return BookingDetails(
        id: json['_id'],
        startdate: json['startdate'] ?? '',
        enddate: json['enddate'] ?? '',
        starttime: json['starttime'] ?? '',
        endtime: json['endtime'] ?? '',
        title: json['title'] ?? '',
        priority: json['priority'] ?? '',
        color: json['color'] ?? '',
        visibility: json['visibility'] ?? '',
        description: json['description'] ?? '',
        notify: json['notify'] ?? '',
        participants: json['participants'] ?? '');
  }
}
