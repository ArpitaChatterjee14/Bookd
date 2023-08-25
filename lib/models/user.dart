import 'dart:convert';

class Details {
  Details({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
  });

  final String id;
  final String username;
  final String email;
  final String phone;

// creating map of above variables
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
    };
  }

// from above map we are putting variables into new UserDetails object. Mutating initial object
  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

// encoding map to json
  String toJson() => json.encode(toMap());

// getting UserDetails object itself
  factory Details.fromJson(json) {
    return Details(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}
