import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';

// виджет реализует строку поиска
class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const SearchBar(
      {Key? key,
      this.height = 52,
      this.suffixIcon,
      this.onTap,
      this.keyboardType,
      this.autofocus = false,
      this.focusNode,
      this.onSubmitted,
      this.onChanged,
      this.controller,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      height: 52,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          border: border,
          enabledBorder: border,
          disabledBorder: border,
          fillColor: theme.colorScheme.surface,
          hintStyle: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.outline,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: AppStrings.search,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgPicture.asset(AppAssets.iconSearch),
          ),
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
        autofocus: autofocus,
        onTap: onTap,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        focusNode: focusNode,
        controller: controller,
      ),
    );
  }
}
