
import 'package:flutter/material.dart';
import 'package:trek_bikes_app/category.dart';
import 'package:trek_bikes_app/category_repository.dart';

class CategoryPage extends StatefulWidget {
  final String title;
  const CategoryPage({super.key, required this.title});
  @override
  State<StatefulWidget> createState() => _CategoryPageState();

}

class _CategoryPageState extends State<CategoryPage>{
  List<Category> categories = [];
  @override
  void initState(){
    super.initState();
    _initData();
  }
  void _initData() async{
    var data = await CategoryRepository.getCategories();
    if (data == null) return;
    setState(() {
      categories = data;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context,index){
          Category item = categories[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.description),
          );
        })
    );
  }
}
  