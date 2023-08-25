import 'dart:convert';

class UserDetails {
  UserDetails({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.token,
    required this.otp,
    required this.friend,
  });

  final String id;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String token;
  final String otp;
  final String friend;

// creating map of above variables
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'token': token,
      'phone': phone,
      'password': password,
      'otp': otp,
      'friend': friend,
    };
  }

// from above map we are putting variables into new UserDetails object. Mutating initial object
  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
      token: map['token'] ?? '',
      otp: map['otp'] ?? '',
      friend: map['friend'] ?? '',
    );
  }

// encoding map to json
  String toJson() => json.encode(toMap());

// getting UserDetails object itself
  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source));
}
