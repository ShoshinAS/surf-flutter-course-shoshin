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
      appBar: const CustomAppBar(
        height: 152,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
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

// Виджет отображает заголовок списка интересных мест
// Предназначен для использования в качестве appBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const CustomAppBar({
    Key? key, required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.bottomLeft,
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: '${AppStrings.appBarTitle1}\n',
              style: TextStyle(
                color: Color(0XFF3B3E5B),
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: AppStrings.appBarTitle2,
              style: TextStyle(
                color: Color(0XFF3B3E5B),
                fontSize: 32,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
