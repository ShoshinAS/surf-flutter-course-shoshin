import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Виджет отображает большую кнопку для отображения внизу экрана
class BigButton extends StatelessWidget {
  final String title;
  final String? icon;
  final VoidCallback onPressed;
  final ValueChanged<bool>? onFocusChange;
  final bool active;

  const BigButton({
    required this.title,
    required this.onPressed,
    this.icon,
    this.onFocusChange,
    this.active = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor =
        active ? theme.colorScheme.secondary : theme.colorScheme.surface;
    final textColor =
        active ? theme.colorScheme.onSecondary : theme.colorScheme.outline;

    return ElevatedButton(
      onPressed: active ? onPressed : null,
      onFocusChange: onFocusChange,
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
              color: textColor,
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
        textStyle: theme.textTheme.labelMedium,
      ).copyWith(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        foregroundColor: MaterialStateProperty.all(textColor),
      ),
    );
  }
}
