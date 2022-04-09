import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/strings.dart';
import 'package:places/ui/screen/sight_card.dart';

// Виджет отображает экран со списком интересных мест
class SightListScreen extends StatelessWidget {

  final List<Sight> sightList;

  const SightListScreen({Key? key, required this.sightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.appBarTitle1.substring(0, 1),
                  style: const TextStyle(
                    color: Color(0XFF4CAF50),
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '${AppStrings.appBarTitle1.substring(1)}\n',
                      style: const TextStyle(
                        color: Color(0XFF3B3E5B),
                        fontSize: 32,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextSpan(
                  text: AppStrings.appBarTitle2.substring(0, 1),
                  style: const TextStyle(
                    color: Color(0XFFFCDD3D),
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.appBarTitle2.substring(1),
                      style: const TextStyle(
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
              children: sightList.map(SightCard.new).toList(),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
