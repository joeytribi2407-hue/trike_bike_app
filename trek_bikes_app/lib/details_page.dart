import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trek_bikes_app/bike.dart';
import 'package:trek_bikes_app/bikerepository.dart';
import 'package:trek_bikes_app/cart.dart';
import 'package:trek_bikes_app/cart_repository.dart';
import 'package:trek_bikes_app/session_helper.dart';

class DetailsPage extends StatefulWidget {
  final String _title;
  const DetailsPage({super.key, required this._title});

  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int? _id;
  Bike? _bike;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _id = ModalRoute.of(context)!.settings.arguments as int;
    _loadBike();
  }

  void _loadBike() async {
    if (_id != null) {
      var item = await BikeRepository.getBike(_id!);
      setState(() {
        _bike = item;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._title)),
      body: Column(
        children: [
          if (_bike != null) ...[
            Image.network(
              '${dotenv.env['API_URL']}//bikes/${_bike!.imageUrl}',
              width: 256,
            ),
            Text(_bike!.name),
            Text('Price: ${_bike!.price}'),
            _loadTable(_bike!),
            ElevatedButton.icon(
              onPressed: _onAddToCart,
              label: Text('Add to Cart'),
            ),
            if (_error != null) Text('Add to Cart Failed'),
          ] else
            Text('Not found data $_id'),
        ],
      ),
    );
  }

  void _onAddToCart() async {
    String? token = await SessionHelper.token;
    if (token != null) {
      Cart obj = Cart(id: 0, memberId: null, bikeId: _id!, quantity: 1);
      int ret = await CartRepository.add(obj, token);
      if (ret > 0) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Add to Cart Success')));
      } else {
        setState(() {
          _error = "Add to Cart Failed";
        });
      }
    }
  }

  Widget _loadTable(Bike item) {
    return Table(
      children: [
        if (item.frame != null)
          TableRow(children: [Text('Frame'), Text(item.frame!)]),
        if (item.weight != null)
          TableRow(children: [Text('Weight'), Text(item.weight!)]),
        if (item.fork != null)
          TableRow(children: [Text('Fork'), Text(item.fork!)]),
        if (item.drivetrain != null)
          TableRow(children: [Text('Drivetrain'), Text(item.drivetrain!)]),
        if (item.brakes != null)
          TableRow(children: [Text('Brakes'), Text(item.brakes!)]),
        if (item.wheels != null)
          TableRow(children: [Text('Wheels'), Text(item.wheels!)]),
        if (item.rearShock != null)
          TableRow(children: [Text('Rear Shock'), Text(item.rearShock!)]),
          if (item.tires != null)
          TableRow(children: [Text('Tires'), Text(item.tires!)]),
      ],
    );
  }
}