import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/empty_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        height: 56,
        actions: [
          _SkipButton(onPressed: () {}),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            onPageChanged: (page) {
              setState(() {
                _page = page;
              });
            },
            children: [
              EmptyState(
                icon: AppAssets.iconOnboardingWelcome,
                titleText: AppStrings.onboardingWelcomeTitle,
                subtitleText: AppStrings.onboardingWelcomeSubtitle,
                titleColor: theme.colorScheme.onTertiary,
                subtitleColor: theme.colorScheme.onSurfaceVariant,
              ),
              EmptyState(
                icon: AppAssets.iconOnboardingRoute,
                titleText: AppStrings.onboardingRouteTitle,
                subtitleText: AppStrings.onboardingRouteSubtitle,
                titleColor: theme.colorScheme.onTertiary,
                subtitleColor: theme.colorScheme.onSurfaceVariant,
              ),
              EmptyState(
                icon: AppAssets.iconOnboardingAddSights,
                titleText: AppStrings.onboardingAddSightsTitle,
                subtitleText: AppStrings.onboardingAddSightsSubtitle,
                titleColor: theme.colorScheme.onTertiary,
                subtitleColor: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          Positioned(
            bottom: 88,
            child: _CustomIndicator(
              length: 3,
              currentPage: _page,
            ),
          ),
        ],
      ),
    );
  }
}

// виджет кнопки "Пропустить"
class _SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SkipButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      child: Text(
        AppStrings.skip,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

// Индикатор текущей страницы PageView
class _CustomIndicator extends StatelessWidget {
  final int length;
  final int currentPage;

  const _CustomIndicator({
    Key? key,
    required this.length,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: List<Widget>.generate(
        length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: (index == currentPage)
                ? colorScheme.secondary
                : colorScheme.outline,
          ),
          width: (index == currentPage) ? 24 : 8,
          height: 8,
        ),
      ),
    );
  }
}
