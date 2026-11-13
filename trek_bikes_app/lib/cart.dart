class Cart{
  final int id;
  final String? memberId;
  final int bikeId;
  final int quantity;
  Cart({required this.id, required this.memberId, required this.bikeId, required this.quantity});
  factory Cart.fromMap(Map<String,dynamic> map){
    return Cart(
      id: map['id'],
      memberId: map['memberId'],
      bikeId: map['bikeId'],
      quantity: map['quantity'],
    );
  }
  Map<String,Object?> toMap(){
    return {
      'id': id,
      'memberId': memberId,
      'bikeId': bikeId,
      'quantity': quantity,
    };
  }
}