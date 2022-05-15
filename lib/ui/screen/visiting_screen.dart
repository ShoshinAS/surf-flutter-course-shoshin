import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/app_bar.dart';
import 'package:places/ui/screen/bottom_navigation_bar.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/typography.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/sight_list.dart';

// виджет отображает экран Хочу посетить / Интересные места
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          AppStrings.favoriteTitle,
          titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
          height: 132,
          bottom: const CustomTabBar(
            height: 52,
            tabs: [
              Tab(
                text: AppStrings.wantToVisitTitle,
              ),
              Tab(
                text: AppStrings.visitedTitle,
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          SightList(
            children:
                wantToVisitSights.map(SightCardInScheduledList.new).toList(),
            emptyScreen: const EmptyScreen(
              iconAssetName: AppAssets.iconFavoriteEmpty,
              description: AppStrings.emptyFavoritesDescription,
            ),
          ),
          SightList(
            children: visitedSights.map(SightCardInVisitedList.new).toList(),
            emptyScreen: const EmptyScreen(
              iconAssetName: AppAssets.iconVisitedEmpty,
              description: AppStrings.emptyVisitedDescription,
            ),
          ),
        ]),
        bottomNavigationBar: const AppBottomNavigationBar(),
      ),
    );
  }
}

// виджет отображает пустой список экрана Хочу посетить / Интересные места
class EmptyScreen extends StatelessWidget {
  final String iconAssetName;
  final String description;
  const EmptyScreen({
    Key? key,
    required this.iconAssetName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 253.5,
        height: 156,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SvgPicture.asset(
              iconAssetName,
              color: Theme.of(context).colorScheme.outline,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.empty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет реализует TapBar для отображения на экране Хочу посетить / Интересные места
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(40),
        ),
        child: TabBar(
          indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(40),
          ),
          unselectedLabelColor:
              Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedLabelStyle: AppTypography.styleSmallBold,
          labelColor: Theme.of(context).colorScheme.onPrimary,
          tabs: tabs,
        ),
      ),
    );
  }
}
