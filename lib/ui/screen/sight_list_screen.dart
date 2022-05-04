import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/app_bar.dart';
import 'package:places/ui/screen/bottom_navigation_bar.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_list.dart';

// Виджет отображает экран со списком интересных мест
class SightListScreen extends StatelessWidget {
  final List<Sight> sightList;

  const SightListScreen({Key? key, required this.sightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        AppStrings.appBarTitle,
        height: 152,
        titleTextStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        alignment: Alignment.bottomLeft,
      ),
      body: Center(
        child: SightList(
          children: sightList.map(SightCardInList.new).toList(),
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
      resizeToAvoidBottomInset: false,
    );
  }
}
