import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/ui/models/theme_model.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

// экран настроек приложения
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.settings,
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onBackground,
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
                  value: themeModel.isDarkTheme,
                  activeColor: theme.colorScheme.secondary,
                  onChanged: (newValue) {
                    setState(() {
                      themeModel.setTheme(isDarkTheme: newValue);
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
                  color: theme.colorScheme.secondary,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: const CircleBorder(),
                  primary: theme.colorScheme.background,
                  onPrimary: theme.colorScheme.onBackground,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ).copyWith(
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/onboarding',
                    arguments: OnboardingSettings(startedByUser: true),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(index: 3),
    );
  }
}

// виджет элемента настрое приложения
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
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.textTheme.bodyLarge),
            child,
          ],
        ),
        Divider(
          height: 12,
          color: theme.colorScheme.outline,
        ),
      ],
    );
  }
}
