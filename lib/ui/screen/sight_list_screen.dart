import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/strings.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screen/app_bar.dart';
import 'package:places/ui/screen/bottom_navigation_bar.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/typography.dart';

// Виджет отображает экран со списком интересных мест
class SightListScreen extends StatelessWidget {
  final List<Sight> sightList;

  const SightListScreen({Key? key, required this.sightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(AppStrings.appBarTitle,
          height: 152,
          style: AppTypography.styleLargeTitle,
          alignment: Alignment.bottomLeft,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: sightList
                  .map(SightCardInList.new)
                  .toList(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
      resizeToAvoidBottomInset: false,
    );
  }
}
