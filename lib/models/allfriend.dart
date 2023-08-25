class Allfriend {
  Allfriend({required this.sId, required this.friends});

  final String sId;
  final List<dynamic> friends;

  factory Allfriend.fromJson(json) {
    return Allfriend(sId: json['_id'] ?? '', friends: json['friends'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['friends'] = this.friends;
    return data;
  }
}

class Allfollow {
  Allfollow({required this.sId, required this.follows});

  final String sId;
  final List<dynamic> follows;

  factory Allfollow.fromJson(json) {
    return Allfollow(sId: json['_id'] ?? '', follows: json['follows'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['follows'] = this.follows;
    return data;
  }
}
