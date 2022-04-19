import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          icon: SvgPicture.asset('res/icons/list.svg'),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('res/icons/heart_full.svg'),
          label: '',
        ),
      ],
    );
  }
}
