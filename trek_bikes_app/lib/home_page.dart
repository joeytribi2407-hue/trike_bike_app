import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trek_bikes_app/bike.dart';
import 'package:trek_bikes_app/bikerepository.dart';
import 'package:trek_bikes_app/category.dart';
import 'package:trek_bikes_app/category_repository.dart';
import 'package:trek_bikes_app/session_helper.dart';
import 'package:trek_bikes_app/sub_category.dart';
import 'package:trek_bikes_app/sub_category_repository.dart';

class HomePage extends StatefulWidget {
  final String _title;

  const HomePage({super.key, required this._title});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> _categories = [];
  List<SubCategory> _subCategories = [];
  List<Bike> _bikes = [];
  int? _categoryId;
  Set<int> _selected = {};
  String? _email;
  void _loadBikes() async {
    List<Bike> data;
    if (_selected.isEmpty){
      if (_categoryId == null){
        data = await BikeRepository.getBikes();
      } else{
        data = await BikeRepository.getBikesByCategory(_categoryId!);
      }
    } else {
      data = await BikeRepository.getBikesBySubCategories(_selected.toList());
    }
    setState(() {
      _bikes = data;
    });
  }

  void _loadCategories() async {
    var data = await CategoryRepository.getCategories();
    setState(() {
      _categories = data!;
    });
  }

  void _loadSubCategories() async {
    var data = _categoryId == null
        ? await SubCategoryRepository.getSubCategories()
        : await SubCategoryRepository.getSubCategoriesByCategory(_categoryId!);
    setState(() {
      _subCategories = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadCategories();
    _loadSubCategories();
    _loadBikes();
  }

  void _loadData() async {
    String? eml = await SessionHelper.email;
    setState(() {
      _email = eml;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(widget._title),
        title: Row(
          children: _categories.map((p) {
            return ChoiceChip(
              label: Text(p.name),
              selected: _categoryId != null && _categoryId == p.id,
              onSelected: (val) {
                setState(() {
                  _categoryId = val ? p.id : null;
                  _selected.clear();
                });
                _loadSubCategories();
                _loadBikes();
              },
            ); // ChoiceChip
          }).toList(),
        ), // Row
        actions: [
          if (_email == null || _email!.isEmpty) ...[
            ElevatedButton.icon(
              onPressed: _login,
              label: const Text('Login'),
              icon: const Icon(Icons.login),
            ), // ElevatedButton.icon
            ElevatedButton.icon(
              onPressed: _register,
              label: const Text('Register'),
              icon: const Icon(Icons.add),
            ), // ElevatedButton.icon
          ] else ...[
            ElevatedButton.icon(
              onPressed: _profile,
              label: const Text('Profile'),
              icon: const Icon(Icons.person),
            ), // ElevatedButton.icon
            ElevatedButton.icon(
              onPressed: _logout,
              label:  Text('Logout'),
              icon:  Icon(Icons.logout),
            ),
            ElevatedButton.icon(
              onPressed: _onCart,
              label:  Text('Cart'),
              icon:  Icon(Icons.shopping_cart),
            ),
            ElevatedButton.icon(
              onPressed: _onInvoice,
              label:  Text('Invoice'),
              icon:  Icon(Icons.shopping_cart_checkout),
            ),// ElevatedButton.icon
          ],
        ],
      ), // AppBar
      body: Column(
        children: [
          Wrap(
            children: _subCategories.map((p) {
              return FilterChip(
                label: Text(p.name),
                onSelected: (val) {
                  setState(() {
                    if (val) {
                      _selected.add(p.id);
                    } else {
                      _selected.remove(p.id);
                    }
                  });
                  _loadBikes();
                },
                selected: _selected.contains(p.id),
              ); // FilterChip
            }).toList(),
          ), // Wrap
          Expanded(
            child: GridView.builder(
              itemCount: _bikes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                Bike item = _bikes[index];
                return Column(
                  children: [
                    Text(item.name),
                    Image.network(
                      '${dotenv.env['API_URL']}/bikes/${item.imageUrl}',
                      width: 128,
                    ),
                    Text('Price: ${item.price}'),
                    ElevatedButton.icon(
                      onPressed: () => _onDetails(item.id),
                      label:Text('Details'),
                      icon: Icon(Icons.details),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ), // Column
    ); // Scaffold
  }

  void _onInvoice()async{
    await Navigator.pushNamed(context, '/invoice');
  }
  void _onCart() async{
    await Navigator.pushNamed(context, '/cart');
  }
  void _onDetails(int id)async{
    await Navigator.pushNamed(context, '/details',arguments:id);
  }
  void _login() async {
    var result = await Navigator.pushNamed(context, '/login');
    if (result == true) {
      _loadData();
    }
  }


  void _register() {
    Navigator.pushNamed(context, '/register');
  }

  void _logout() async {
    await SessionHelper.delete();
    setState(() {
      _email = null;
    });
  }

  void _profile() async {
    Navigator.pushNamed(context, '/profile');
  }
}