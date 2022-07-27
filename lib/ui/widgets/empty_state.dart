import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// виджет empty state
class EmptyState extends StatelessWidget {
  final String icon;
  final String titleText;
  final String subtitleText;
  final Color titleColor;
  final Color subtitleColor;
  final double? iconHeight;
  final double? iconWidth;

  const EmptyState(
      {Key? key,
        required this.icon,
        required this.titleText,
        required this.subtitleText,
        required this.titleColor,
        required this.subtitleColor,
        this.iconHeight,
        this.iconWidth,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: iconHeight,
            width: iconWidth,
            color: titleColor,
          ),
          const SizedBox(height: 24),
          Text(
            titleText,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: titleColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitleText,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}
