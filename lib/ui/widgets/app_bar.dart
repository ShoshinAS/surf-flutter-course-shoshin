import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/assets.dart';

// Виджет отображает заголовок списка интересных мест
// Предназначен для использования в качестве appBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final TextStyle? titleTextStyle;
  final MainAxisAlignment mainAxisAlignment;
  final PreferredSizeWidget? bottom;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const CustomAppBar({
    Key? key,
    required this.height,
    this.title,
    this.titleTextStyle,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.bottom,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            const SizedBox(width: 16),
            if (leading != null) leading! else const SizedBox.shrink(),
            if (title != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  title!,
                  style: titleTextStyle ??
                      theme.appBarTheme.titleTextStyle,
                ),
              )
            else
              const Expanded(child: SizedBox()),
            if (actions != null)
              Row(children: actions!)
            else
              const SizedBox.shrink(),
            const SizedBox(width: 16),
          ],
        ),
        Container(
          child: bottom,
        ),
      ],
    );
  }
}

class ReturnButton extends StatelessWidget {
  const ReturnButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        primary: theme.colorScheme.tertiary,
        onPrimary: theme.colorScheme.onTertiary,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        minimumSize: const Size.square(32),
        maximumSize: const Size.square(32),
      ).copyWith(
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: () => debugPrint('Нажата кнопка "Вернуться"'),
      child: SvgPicture.asset(
        AppAssets.iconArrow,
        color: theme.colorScheme.onTertiary,
      ),
    );
  }
}
