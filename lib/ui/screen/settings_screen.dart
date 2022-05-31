import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/models/theme_model.dart';
import 'package:places/ui/screen/app_bar.dart';
import 'package:places/ui/screen/bottom_navigation_bar.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/typography.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.settings,
        titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
        height: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _SettingsItem(
              title: AppStrings.darkTheme,
              child: Consumer<ThemeModel>(
                builder: (context, themeModel, child) => Switch(
                  value: themeModel.darkTheme,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (newValue) {
                    setState(() {
                      themeModel.darkTheme = newValue;
                    });
                  },
                ),
              ),
            ),
            _SettingsItem(
              title: AppStrings.watchTutorial,
              child: ElevatedButton(
                child: SvgPicture.asset(
                  AppAssets.iconInfo,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: CircleBorder(),
                  primary: Theme.of(context).colorScheme.background,
                  onPrimary: Theme.of(context).colorScheme.onBackground,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ).copyWith(
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () {
                  debugPrint('Нажата кнопка "Смотреть туториал"');
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsItem({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTypography.styleMenu),
            child,
          ],
        ),
        Divider(
          height: 12,
          color: Theme.of(context).colorScheme.outline,
        ),
      ],
    );
  }
}
