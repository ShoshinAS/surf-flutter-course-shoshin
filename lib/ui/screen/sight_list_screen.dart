import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatelessWidget {

  const SightListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 112,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SightCard(mocks[0]),
                SightCard(mocks[1]),
                SightCard(mocks[2]),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
