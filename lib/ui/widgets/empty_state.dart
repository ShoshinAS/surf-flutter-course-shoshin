import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// виджет empty state
class EmptyState extends StatelessWidget {
  final String icon;
  final String titleText;
  final String subtitleText;

  const EmptyState(
      {Key? key,
      required this.icon,
      required this.titleText,
      required this.subtitleText,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.outline;

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 64,
              width: 64,
              color: color,
            ),
            const SizedBox(height: 24),
            Text(
              titleText,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitleText,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
