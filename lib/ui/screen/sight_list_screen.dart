import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list.dart';

// Виджет отображает экран со списком интересных мест
class SightListScreen extends StatelessWidget {
  final List<Sight> sightList;

  const SightListScreen({Key? key, required this.sightList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: CustomAppBar(
        title: AppStrings.appBarTitle,
        height: 128,
        titleTextStyle: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onBackground,
            ),
        mainAxisAlignment: MainAxisAlignment.start,
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
