import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/empty_state.dart';

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return EmptyState(
      icon: AppAssets.iconDeleteCircle,
      titleText: AppStrings.error,
      subtitleText: AppStrings.somethingWentWrong,
      titleColor: theme.colorScheme.outline,
      subtitleColor: theme.colorScheme.outline,
      iconHeight: 64,
      iconWidth: 64,
    );
  }
}
