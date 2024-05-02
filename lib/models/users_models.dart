class UserIpray {
  UserIpray({required this.id, required this.name, required this.email, required this.urlImage, required this.age, required this.state, required this.city, required this.total, required this.streak, required this.createdDate, this.deviceToken, required this.dateLastPray});

  final int id;
  final String name;
  final String email;
  final String urlImage;
  final int age;
  final String state;
  final String city;
  final int total;
  final int streak;
  final DateTime createdDate;
  final String? deviceToken;
  final DateTime? dateLastPray;

  UserIpray copyWith({int? id, String? name, String? email, String? urlImage, int? age, String? state, String? city, int? total, int? streak, DateTime? createdDate, String? deviceToken, DateTime? dateLastPray}) {
    return UserIpray(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      urlImage: urlImage ?? this.urlImage,
      age: age ?? this.age,
      state: state ?? this.state,
      city: city ?? this.city,
      total: total ?? this.total,
      streak: streak ?? this.streak,
      createdDate: createdDate ?? this.createdDate,
      deviceToken: deviceToken ?? this.deviceToken,
      dateLastPray: dateLastPray ?? this.dateLastPray,
    );
  }

  factory UserIpray.fromJson(Map<String, dynamic> json) {
    return UserIpray(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      urlImage: json['url_image'] as String,
      age: json['age'] as int,
      state: json['state'] as String,
      city: json['city'] as String,
      total: json['total'] as int,
      streak: json['streak'] as int,
      createdDate: DateTime.parse(json['created_date'] as String),
      deviceToken: json['device_token'] as String?,
      dateLastPray: json['date_last_pray'] != null ? DateTime.parse(json['date_last_pray'] as String) : null,
    );
  }



  @override
  String toString() {
    return 'UserIpray(id: $id, name: $name, email: $email, urlImage: $urlImage, age: $age, state: $state, city: $city, total: $total, streak: $streak, createdDate: $createdDate, token: $deviceToken, dateLastPray: $dateLastPray)';
  }
}

class CacheException {
  final String error;
  final String message;

  CacheException({required this.error, required this.message});
}

class BibleVerse {
  final String livro;
  final String frase;
  final int capitulo;
  final int versiculo;

  BibleVerse({
    required this.livro,
    required this.frase,
    required this.capitulo,
    required this.versiculo,
  });
}
