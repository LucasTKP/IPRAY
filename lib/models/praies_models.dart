class Praies {
  Praies({
    required this.id,
    required this.idUser,
    required this.date,
  });

  final int id;
  final int idUser;
  final DateTime date;

  factory Praies.fromJson(Map<String, dynamic> json) {
    return Praies(
      id: json['id'] ?? 0,
      idUser: json['id_user'] ?? 0,
      date: json['date'] != null ? DateTime.parse(json['date']) :  DateTime.now(),
    );
  }

  @override
  String toString() => 'Pray(id: $id, idUser: $idUser, createdDate: $date)';
}
