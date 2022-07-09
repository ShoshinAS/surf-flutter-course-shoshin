import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/assets.dart';

// Виджет отображает заголовок списка интересных мест
// Предназначен для использования в качестве appBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final TextStyle? titleTextStyle;
  final AlignmentGeometry? alignment;
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
    this.alignment = Alignment.center,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: (leading != null) ? leading! : const SizedBox.shrink(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: alignment,
                child: (title != null)
                    ? Text(
                        title!,
                        style:
                            titleTextStyle ?? theme.appBarTheme.titleTextStyle,
                      )
                    : const SizedBox.shrink(),
              ),
              Positioned(
                right: 0,
                child: (actions != null)
                    ? Row(children: actions!)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
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
      onPressed: () => Navigator.pop(context),
      child: SvgPicture.asset(
        AppAssets.iconArrow,
        color: theme.colorScheme.onTertiary,
      ),
    );
  }
}
