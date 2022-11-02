import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/router.dart';

// кастомизированный BottomNavigationBar
class AppBottomNavigationBar extends StatelessWidget {
  final int index;

  const AppBottomNavigationBar({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.onBackground;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline,
            width: 0.8,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: theme.colorScheme.background,
        type: BottomNavigationBarType.fixed,
        onTap: (selectedIndex) {
          _onSelectItem(
            selectedIndex,
            Navigator.of(context),
          );
        },
        items: [
          _CustomBottomNavigationBarItem(
            iconAsset: AppAssets.iconList,
            activeIconAsset: AppAssets.iconListFill,
            color: iconColor,
          ),
          _CustomBottomNavigationBarItem(
            iconAsset: AppAssets.iconMap,
            activeIconAsset: AppAssets.iconMapFill,
            color: iconColor,
          ),
          _CustomBottomNavigationBarItem(
            iconAsset: AppAssets.iconHeart,
            activeIconAsset: AppAssets.iconHeartFill,
            color: iconColor,
          ),
          _CustomBottomNavigationBarItem(
            iconAsset: AppAssets.iconSettings,
            activeIconAsset: AppAssets.iconSettingsFill,
            color: iconColor,
          ),
        ],
      ),
    );
  }

  void _onSelectItem(int selectedIndex, NavigatorState navigatorState) {
    if (selectedIndex == index) {
      return;
    }
    var routeName = '';
    switch (selectedIndex) {
      case 0:
        routeName = AppRouter.list;
        break;
      case 1:
        routeName = AppRouter.map;
        break;
      case 2:
        routeName = AppRouter.visiting;
        break;
      case 3:
        routeName = AppRouter.settings;
        break;
    }
    navigatorState.pushNamed(routeName);
  }
}

class _CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  final String iconAsset;
  final String activeIconAsset;
  final Color color;

  _CustomBottomNavigationBarItem({
    required this.iconAsset,
    required this.activeIconAsset,
    required this.color,
  }) : super(
          icon: SvgPicture.asset(
            iconAsset,
            color: color,
          ),
          activeIcon: SvgPicture.asset(
            activeIconAsset,
            color: color,
          ),
          label: '',
        );
}
