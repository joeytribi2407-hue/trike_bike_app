class Invoice{
  final int id;
  final int statusId;
  final String? memberId;
  final DateTime? dated;

  Invoice({
    required this.id,
    required this.statusId,
    required this.memberId,
    required this.dated,
  });
  Map<String,Object?> toMap(){
    return{
      'id':id,
      'memberId': memberId,
      'statusId': statusId,
      'date': dated,
    };
  }
  factory Invoice.fromMap(Map<String,dynamic>map){
    return Invoice(
      id: map['id'],
      memberId: map['memberId'],
      statusId: map['statusId'],
      dated:DateTime.parse(map['dated']),
    );
  }
}