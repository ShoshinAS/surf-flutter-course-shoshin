import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/app_bar.dart';
import 'package:places/ui/screen/big_button.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/typography.dart';

// Виджет отображает детальную информацию об интересном месте
// для отображения на отдельном экране
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          _SightImage(sight: sight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _SightDetailsName(sight: sight),
                const SizedBox(height: 2),
                Row(
                  children: [
                    _SightDetailsType(sight: sight),
                    const SizedBox(width: 16),
                    const _SightOpeningHours(),
                  ],
                ),
                const SizedBox(height: 24),
                _SightDescription(sight: sight),
                const SizedBox(height: 24),
                BigButton(
                    title: AppStrings.route,
                    icon: AppAssets.iconGo,
                    onPressed: () => debugPrint('Нажата кнопка "Построить маршрут"'),
                ),
                const SizedBox(height: 24),
                const Divider(),
              ],
            ),
          ),
          const _BottomPanel(),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

// Виджет отображает краткое описание интересного места на экране информации
class _SightDescription extends StatelessWidget {
  final Sight sight;

  const _SightDescription({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.details,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
      overflow: TextOverflow.clip,
    );
  }
}

// Виджет отображает информацию о времени открытия интересного места
class _SightOpeningHours extends StatelessWidget {
  const _SightOpeningHours({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      MockStrings.openingHours,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

// Виджет отображает информацию о типе интересного места
class _SightDetailsType extends StatelessWidget {
  final Sight sight;

  const _SightDetailsType({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.type.toString(),
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }
}

// Виджет отображает имя интересного места
class _SightDetailsName extends StatelessWidget {
  final Sight sight;

  const _SightDetailsName({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.name,
      style: AppTypography.styleTitle,
    );
  }
}

// Виджет отображает нижнюю панель
class _BottomPanel extends StatelessWidget {
  const _BottomPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8,
      ),
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          _BottomButton(
            text: AppStrings.plan,
            active: false,
            icon: AppAssets.iconCalendar,
            onPressed: () => debugPrint('Нажата кнопка "Запланировать"'),
          ),
          _BottomButton(
            text: AppStrings.toFavourites,
            active: true,
            icon: AppAssets.iconHeart,
            onPressed: () => debugPrint('Нажата кнопка "В Избранное"'),
          ),
        ],
      ),
    );
  }
}

// Виджет отображает изображение интересного места
// с кнопкой возврата на предыдущий экран
class _SightImage extends StatelessWidget {
  final Sight sight;

  const _SightImage({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Image.network(
            sight.url,
            fit: BoxFit.cover,
            height: 360,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          const Positioned(
            child: ReturnButton(),
            left: 16,
            top: 36,
          ),
        ],
      ),
    );
  }
}

// Виджет отображает кнопки в нижней панели экрана
class _BottomButton extends StatelessWidget {
  final String text;
  final bool active;
  final String icon;
  final VoidCallback onPressed;

  const _BottomButton({
    required this.text,
    required this.active,
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = active
        ? Theme.of(context).colorScheme.onBackground
        : Theme.of(context).colorScheme.outline;

    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          color: color,
        ),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 40),
          textStyle: Theme.of(context).textTheme.bodyMedium,
          primary: Theme.of(context).colorScheme.background,
          onPrimary: color,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ).copyWith(
          elevation: MaterialStateProperty.all(0),
        ),
      ),
    );
  }
}
