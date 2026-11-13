class Status {
  final int id;
  final String name;
  Status({required this.id, required this.name});
  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(id: map['id'], name: map['name']);
  }
}