import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Виджет отображает большую кнопку для отображения внизу экрана
class BigButton extends StatelessWidget {
  final String title;
  final String? icon;
  final VoidCallback onPressed;

  const BigButton({
    required this.title,
    required this.onPressed,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon == null)
            const SizedBox.shrink()
          else
            SvgPicture.asset(
              icon!,
              width: 24,
              height: 24,
            ),
          if (icon == null)
            const SizedBox.shrink()
          else
            const SizedBox(width: 10),
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 46),
        primary: theme.colorScheme.secondary,
        onPrimary: theme.colorScheme.onSecondary,
        textStyle: theme.textTheme.labelMedium,
      ),
    );
  }
}
