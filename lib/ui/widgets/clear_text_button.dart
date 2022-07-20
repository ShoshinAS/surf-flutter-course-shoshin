import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/assets.dart';

// кнопка для очистки текста в текстовом поле
class ClearTextButton extends StatelessWidget {
  final bool visible;
  final TextEditingController controller;
  final VoidCallback? onClear;

  const ClearTextButton(
      {Key? key, this.visible = true, this.onClear, required this.controller,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Visibility(
      visible: visible,
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          icon: SvgPicture.asset(
            AppAssets.iconClear,
            color: theme.colorScheme.onTertiary,
          ),
          splashRadius: 16,
          constraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          onPressed: () {
            controller.clear();
            onClear?.call();
          },
        ),
      ),
    );
  }
}
