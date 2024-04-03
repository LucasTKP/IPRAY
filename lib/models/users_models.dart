class UserIpray {
  UserIpray({
    required this.id,
    required this.name,
    required this.email,
    required this.urlImage,
    required this.age,
    required this.state,
    required this.city,
    required this.total,
    required this.streak,
    required this.createdDate,
  });

  late final int id;
  late final String name;
  late final String email;
  late final String urlImage;
  late final int age;
  late final String state;
  late final String city;
  late final int total;
  late final int streak;
  late final DateTime createdDate;

  UserIpray copyWith({
    int? id,
    String? name,
    String? email,
    String? urlImage,
    int? age,
    String? state,
    String? city,
    int? total,
    int? streak,
    DateTime? createdDate,
  }) {
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
    );
  }

  UserIpray.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    urlImage = json['urlImage'] ?? '';
    age = json['age'] ?? 0;
    state = json['state'] ?? '';
    city = json['city'] ?? '';
    total = json['total'] ?? 0;
    streak = json['streak'] ?? 0;
    createdDate = json['created_date'] != null
        ? DateTime.parse(json['created_date'])
        : DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'urlImage': urlImage,
      'age': age,
      'state': state,
      'city': city,
      'total': total,
      'streak': streak,
      'created_date': createdDate.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'UserIpray{id: $id, name: $name, email: $email, urlImage: $urlImage, age: $age, state: $state, city: $city, total: $total, streak: $streak, createdDate: $createdDate}';
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
