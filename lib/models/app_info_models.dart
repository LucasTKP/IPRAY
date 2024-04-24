class AppInfo {
  AppInfo({required this.id, required this.createdAt, required this.version, required this.note});

  final int id;
  final DateTime createdAt;
  final String version;
  final String note;


  factory AppInfo.fromJson(Map<String, dynamic> json) {
    return AppInfo(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      version: json['version'],
      note: json['note'],
    );
  }

  @override
  String toString() {
    return 'AppInfo(id: $id, createdAt: $createdAt, version: $version, note: $note)';
  }
}
