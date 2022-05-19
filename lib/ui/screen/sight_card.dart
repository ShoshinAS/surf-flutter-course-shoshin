import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/colors.dart';

// Виджет реализует абстрактный класс для отображения карточки интересного места в списке
abstract class SightCard extends StatelessWidget {
  final Sight sight;
  final Widget extraInformation;
  final List<Widget> buttons;

  const SightCard(
    this.sight, {
    Key? key,
    this.extraInformation = const Text(''),
    this.buttons = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              children: [
                _SightCardImage(sight: sight),
                _SightCardType(sight: sight),
                _SightCardButtonPanel(buttons: buttons),
              ],
            ),
          ),
          Expanded(
            child: _SightCardDescription(
              header: _SightCardName(sight: sight),
              firstLine: extraInformation,
              secondLine: const _SightCardOpeningTime(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Виджет отображает карточку интересного места в списке
class SightCardInList extends SightCard {
  SightCardInList(Sight sight, {Key? key})
      : super(
          sight,
          key: key,
          buttons: [_AddToFavoritesButton(sight: sight)],
        );
}

// Виджет отображает карточку интересного места в списке "Хочу посетить"
class SightCardInScheduledList extends SightCard {
  SightCardInScheduledList(Sight sight, {Key? key})
      : super(
          sight,
          key: key,
          extraInformation: const ScheduledDate(),
          buttons: [
            _AddToCalendarButton(sight: sight),
            _RemoveFromFavorites(sight: sight),
          ],
        );
}

class ScheduledDate extends StatelessWidget {
  const ScheduledDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      MockStrings.scheduledDate,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }
}

// Виджет отображает карточку интересного места в списке "Посетил"
class SightCardInVisitedList extends SightCard {
  SightCardInVisitedList(Sight sight, {Key? key})
      : super(
          sight,
          key: key,
          extraInformation: const VisitDate(),
          buttons: [
            _ShareButton(sight: sight),
            _RemoveFromFavorites(sight: sight),
          ],
        );
}

class VisitDate extends StatelessWidget {
  const VisitDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      MockStrings.visitDate,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

// Виджет отображает группу кнопок, расположенную поверх изображения
class _SightCardButtonPanel extends StatelessWidget {
  final List<Widget> buttons;

  const _SightCardButtonPanel({Key? key, required this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Row(
        children: buttons,
      ),
      top: 16,
      right: 16,
    );
  }
}

// Виджет отображает кнопку на панели _SightCardButtonPanel
class _SightCardButton extends StatelessWidget {
  final String icon;
  final Sight sight;
  final VoidCallback onPressed;

  const _SightCardButton({required this.icon, required this.sight, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 0,
        height: 0,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: SvgPicture.asset(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _AddToFavoritesButton extends StatelessWidget {
  final Sight sight;

  const _AddToFavoritesButton({required this.sight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SightCardButton(
        icon: AppAssets.iconHeart,
        sight: sight,
        onPressed: () => debugPrint('Нажата кнопка "Добавить в избранное" - ${sight.name}'),
    );
  }
}

class _AddToCalendarButton extends StatelessWidget {
  final Sight sight;

  const _AddToCalendarButton({required this.sight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SightCardButton(
      icon: AppAssets.iconCalendar,
      sight: sight,
      onPressed: () => debugPrint('Нажата кнопка "Запланировать к посещению" - ${sight.name}'),
    );
  }
}

class _ShareButton extends StatelessWidget {
  final Sight sight;

  const _ShareButton({required this.sight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SightCardButton(
      icon: AppAssets.iconShare,
      sight: sight,
      onPressed: () => debugPrint('Нажата кнопка "Поделиться" - ${sight.name}'),
    );
  }
}

class _RemoveFromFavorites extends StatelessWidget {
  final Sight sight;

  const _RemoveFromFavorites({required this.sight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SightCardButton(
      icon: AppAssets.iconRemove,
      sight: sight,
      onPressed: () => debugPrint('Нажата кнопка "Удалить из избранного" - ${sight.name}'),
    );
  }
}

// Виджет отображает блок текстового описания интересного места в списке
class _SightCardDescription extends StatelessWidget {
  final Widget header;
  final Widget firstLine;
  final Widget secondLine;

  const _SightCardDescription({
    Key? key,
    required this.header,
    required this.firstLine,
    required this.secondLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 92,
        minWidth: double.infinity,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          header,
          const SizedBox(height: 2),
          Expanded(child: firstLine),
          const SizedBox(height: 2),
          secondLine,
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Виджет отображает краткое описание интересного места в списке
class _SightCardOpeningTime extends StatelessWidget {
  const _SightCardOpeningTime({
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

// Виджет отображает имя интересного места в списке
class _SightCardName extends StatelessWidget {
  final Sight sight;

  const _SightCardName({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.name,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }
}

// Виджет отображает тип интересного места в списке
class _SightCardType extends StatelessWidget {
  final Sight sight;

  const _SightCardType({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Text(
        sight.type,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.white,
            ),
      ),
      top: 16,
      left: 16,
    );
  }
}

// Виджет отображает картинку интересного места в списке
class _SightCardImage extends StatelessWidget {
  final Sight sight;

  const _SightCardImage({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.network(
        sight.url,
        width: double.infinity,
        fit: BoxFit.cover,
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
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    );
  }
}
