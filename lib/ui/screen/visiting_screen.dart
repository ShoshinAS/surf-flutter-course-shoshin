import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/strings.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screen/app_bar.dart';
import 'package:places/ui/screen/bottom_navigation_bar.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/typography.dart';

// виджет отображает экран Хочу посетить / Интересные места
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const CustomAppBar(AppStrings.favoriteTitle,
            height: 80,
            style: AppTypography.styleSubtitle,
            alignment: Alignment.bottomCenter,),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 6),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColors.sightCardColor,
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: AppColors.fontColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  unselectedLabelColor: AppColors.fontColorGray,
                  tabs: const [
                    Tab(
                      text: AppStrings.wantToVisitTitle,
                    ),
                    Tab(
                      text: AppStrings.visitedTitle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: TabBarView(children: [
                  SingleChildScrollView(
                    child: Column(
                      children: wantToVisitSights
                          .map(SightCardInScheduledList.new)
                          .toList(),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: visitedSights
                          .map(SightCardInVisitedList.new)
                          .toList(),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const AppBottomNavigationBar(),
      ),
    );
  }
}