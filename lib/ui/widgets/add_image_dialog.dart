import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/network_image.dart';

// Диалог выбора источника изображения для нового интересного места
class AddImageDialog extends StatelessWidget {
  const AddImageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 152,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _DialogButton(
                    onPressed: () => _selectRandomImage(context),
                    text: AppStrings.camera,
                    icon: AppAssets.iconCamera,
                  ),
                  const _DialogDivider(),
                  _DialogButton(
                    onPressed: () => _selectRandomImage(context),
                    text: AppStrings.photo,
                    icon: AppAssets.iconPhoto,
                  ),
                  const _DialogDivider(),
                  _DialogButton(
                    onPressed: () => _selectRandomImage(context),
                    text: AppStrings.file,
                    icon: AppAssets.iconFile,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          _CancelButton(
            onPressed: () => _cancel(context),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  void _selectRandomImage(BuildContext context) {
    Navigator.of(context).pop([
      CustomImage(
        MockImages.randomURL(),
        height: 72,
        width: 72,
      ),
    ]);
  }

  void _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

}

// кнопка Отмена
class _CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CancelButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme.colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fixedSize: const Size(double.maxFinite, 48),
      ),
      onPressed: onPressed,
      child: Text(
        AppStrings.cancel,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

// разделитель между кнопками выбора источника изображения
class _DialogDivider extends StatelessWidget {
  const _DialogDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Divider(
      height: 0,
      color: theme.colorScheme.outline,
      thickness: 0.8,
    );
  }
}

// кнопка выбора источника изображения интересного места
class _DialogButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final String text;

  const _DialogButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 12),
          Text(
            text,
            style: theme.textTheme.bodyLarge
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
