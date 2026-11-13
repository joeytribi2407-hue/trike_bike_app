class Category{
  final int id;
  final String name;
  final String description;
  final String icon;
  Category({required this.id, required this.name, required this.description, required this.icon});


  factory Category.fromMap(Map<String, dynamic> map){
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      icon: map['icon']
    );
  }
}