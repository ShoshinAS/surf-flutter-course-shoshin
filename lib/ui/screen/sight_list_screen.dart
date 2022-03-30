import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  final _BackgroundColor = Colors.white;

  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget._BackgroundColor,
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Text(
              'Список\nинтересных мест',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0XFF3B3E5B),
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        backgroundColor: widget._BackgroundColor,
        elevation: 0,
        toolbarHeight: 112,
      ),
      body: const Center(
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
