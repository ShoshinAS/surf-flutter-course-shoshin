import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/assets.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.iconList),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppAssets.iconHeartFull),
          label: '',
        ),
      ],
    );
  }
}
