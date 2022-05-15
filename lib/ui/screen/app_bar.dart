import 'package:flutter/material.dart';

// Виджет отображает заголовок списка интересных мест
// Предназначен для использования в качестве appBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String data;
  final double height;
  final TextStyle? titleTextStyle;
  final Alignment? alignment;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const CustomAppBar(
    this.data, {
    Key? key,
    required this.height,
    required this.titleTextStyle,
    this.alignment,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: alignment,
          child: Text(
            data,
            style:
                titleTextStyle ?? Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        Container(
          child: bottom,
        ),
      ],
    );
  }
}
