class Praies {
  Praies({
    required this.id,
    required this.idUser,
    required this.date,
  });

  late final int id;
  late final int idUser;
  late final DateTime date;

  Praies.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    idUser = json['id_user'] ?? 0;
    date = json['date'] != null ? DateTime.parse(json['date']) : DateTime.now();
  }

  @override
  String toString() => 'Pray(id: $id, idUser: $idUser, createdDate: $date)';
}
