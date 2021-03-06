import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/big_button.dart';
import 'package:places/ui/widgets/network_image.dart';

// Виджет отображает детальную информацию об интересном месте
// для отображения на отдельном экране
class SightDetailsScreen extends StatelessWidget {
  final Sight sight;

  const SightDetailsScreen(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Column(
        children: [
          _SightImages(sight: sight),
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
                  onPressed: () =>
                      debugPrint('Нажата кнопка "Построить маршрут"'),
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
    final theme = Theme.of(context);

    return Text(
      sight.details,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onBackground,
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
    final theme = Theme.of(context);

    return Text(
      MockStrings.openingHours,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
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
    final theme = Theme.of(context);

    return Text(
      sight.type.toString(),
      style: theme.textTheme.titleSmall?.copyWith(
        color: theme.colorScheme.onSurface,
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
    final theme = Theme.of(context);

    return Text(
      sight.name,
      style: theme.textTheme.titleLarge,
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
class _SightImages extends StatefulWidget {
  final Sight sight;

  const _SightImages({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  State<_SightImages> createState() => _SightImagesState();
}

class _SightImagesState extends State<_SightImages> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.sight.imageURLs.length,
            itemBuilder: (context, index) => CustomImage(
              widget.sight.imageURLs[index],
              height: 360,
              width: double.infinity,
            ),
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
          const Positioned(
            child: ReturnButton(),
            left: 16,
            top: 36,
          ),
          Positioned(
            bottom: 0,
            child: _CustomIndicator(
              length: widget.sight.imageURLs.length,
              currentPage: _currentPage,
            ),
          ),
        ],
      ),
    );
  }
}

// Виджет реализует индикатор перелистывания PageView с галереей фото
class _CustomIndicator extends StatelessWidget {
  final int length;
  final int currentPage;

  const _CustomIndicator({
    Key? key,
    required this.length,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onTertiary;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: List<Expanded>.generate(
          length,
          (index) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: (index == 0)
                      ? Radius.zero
                      : const Radius.circular(8),
                  right: (index == length - 1)
                      ? Radius.zero
                      : const Radius.circular(8),
                ),
                color: (index == currentPage)
                    ? color
                    : Colors.transparent,
              ),
              height: 7.57,
            ),
          ),
        ),
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
    final theme = Theme.of(context);
    final color =
        active ? theme.colorScheme.onBackground : theme.colorScheme.outline;

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
          textStyle: theme.textTheme.bodyMedium,
          primary: theme.colorScheme.background,
          onPrimary: color,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ).copyWith(
          elevation: MaterialStateProperty.all(0),
        ),
      ),
    );
  }
}
