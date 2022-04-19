// Виджет отображает заголовок списка интересных мест
// Предназначен для использования в качестве appBar
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String data;
  final double height;
  final TextStyle? style;
  final Alignment? alignment;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const CustomAppBar(
      this.data, {
        Key? key,
        required this.height,
        this.style,
        this.alignment,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: alignment,
      child: Text(
        data,
        style: style,
      ),
    );
  }
}
