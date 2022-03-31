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
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'С',
                  style: TextStyle(
                    color: Color(0XFF4CAF50),
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'писок\n',
                      style: TextStyle(
                        color: Color(0XFF3B3E5B),
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextSpan(
                  text: 'и',
                  style: TextStyle(
                    color: Color(0XFFFCDD3D),
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'нтересных мест',
                      style: TextStyle(
                        color: Color(0XFF3B3E5B),
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
        backgroundColor: widget._BackgroundColor,
        elevation: 0,
        toolbarHeight: 112,
      ),
      body: const Center(),
      resizeToAvoidBottomInset: false,
    );
  }
}
