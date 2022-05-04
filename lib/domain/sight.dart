import 'package:flutter/material.dart';

class Sight{
  String name = '';
  double lat = 0.0;
  double lon = 0.0;
  String url = '';
  String details = '';
  String type = '';

  Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.details,
    required this.type,
});
}
class asd extends StatelessWidget {
  const asd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child:Text("test"));
  }
}
