class Member{
  final String? id;
  final String givenName;
  final String? surname;
  final String email;
  final String password;
  final int role;
  Member({
    required this.id,
    required this.email,
    required this.givenName,
    required this.password,
    required this.surname,
    required this.role,
  });
  Map<String,Object?> toMap(){
    return{
      'id':id,
      'givenName':givenName,
      'surname':surname,
      'email':email,
      'password':password,
      'role':role,
  };
}

factory Member.fromMap(Map<String,dynamic> map){
  return Member(
    id: map['id'],
    givenName: map['givenName'],
    surname: map['surname'] ,
    email: map['email'] ,
    password: map['password'] ,
    role: map['role'] ,
  );

}
}