import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/models/place_type_synonym.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/widgets/network_image.dart';
import 'package:places/ui/widgets/sight_details_bottomsheet.dart';

// Виджет реализует абстрактный класс для отображения карточки интересного места в списке
abstract class SightCard extends StatelessWidget {
  final Place sight;
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
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 192,
        width: MediaQuery.of(context).size.width - 32,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: CustomImage(
                        sight.coverURL,
                        width: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: _SightCardDescription(
                        header: _SightCardName(sight: sight),
                        firstLine: extraInformation,
                        secondLine: const _SightCardOpeningTime(),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) =>
                              SightDetailsBottomSheet(
                                sightId: sight.id,
                              ),
                        );
                      },
                    ),
                  ),
                ),
                _SightCardType(sight: sight),
                _SightCardButtonPanel(buttons: buttons),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Виджет отображает карточку интересного места в списке
class SightCardInList extends SightCard {
  SightCardInList(Place sight,
      {required bool inFavorites,
      required ValueChanged<Place> onAddToFavorites,
      required ValueChanged<Place> onRemoveFromFavorites,
      Key? key,
      })
      : super(
          sight,
          key: key,
          buttons: [
            _AddToFavoritesButton(
              sight: sight,
              inFavorites: inFavorites,
              onAddToFavorites: onAddToFavorites,
              onRemoveFromFavorites: onRemoveFromFavorites,
            ),
          ],
        );
}

// Виджет отображает карточку интересного места в списке "Хочу посетить"
class SightCardInScheduledList extends SightCard {
  SightCardInScheduledList(
    Place sight, {
    Key? key,
    required ValueChanged<Place> onRemove,
  }) : super(
          sight,
          key: key,
          extraInformation: const _ScheduledDate(),
          buttons: [
            _AddToCalendarButton(sight: sight),
            _RemoveFromFavorites(
              sight: sight,
              onRemove: onRemove,
            ),
          ],
        );
}

// Виджет отображает карточку интересного места в списке "Посетил"
class SightCardInVisitedList extends SightCard {
  SightCardInVisitedList(
    Place sight, {
    Key? key,
    ValueChanged<Place>? onRemove,
  }) : super(
          sight,
          key: key,
          extraInformation: const _VisitDate(),
          buttons: [
            _ShareButton(sight: sight),
            _RemoveFromFavorites(
              sight: sight,
              onRemove: onRemove,
            ),
          ],
        );
}

class _ScheduledDate extends StatelessWidget {
  const _ScheduledDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      MockStrings.scheduledDate,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.secondary,
      ),
    );
  }
}

class _VisitDate extends StatelessWidget {
  const _VisitDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      MockStrings.visitDate,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
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
      top: 8,
      right: 8,
    );
  }
}

// Виджет отображает кнопку на панели _SightCardButtonPanel
class _SightCardButton extends StatelessWidget {
  final String icon;
  final Place sight;
  final VoidCallback onPressed;

  const _SightCardButton({
    required this.icon,
    required this.sight,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        icon: SvgPicture.asset(
          icon,
          color: AppColors.white,
        ),
        constraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        splashRadius: 16,
        onPressed: onPressed,
      ),
    );
  }
}

class _AddToFavoritesButton extends StatelessWidget {
  final Place sight;
  final bool inFavorites;
  final ValueChanged<Place> onAddToFavorites;
  final ValueChanged<Place> onRemoveFromFavorites;

  const _AddToFavoritesButton({
    Key? key,
    required this.sight,
    required this.inFavorites,
    required this.onAddToFavorites,
    required this.onRemoveFromFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return _SightCardButton(
      icon: inFavorites ? AppAssets.iconHeartFill : AppAssets.iconHeart,
      sight: sight,
      onPressed: () {
        if (inFavorites) {
          onRemoveFromFavorites(sight);
        } else {
          onAddToFavorites(sight);
        }
      },
    );
  }
}

class _AddToCalendarButton extends StatelessWidget {
  final Place sight;

  const _AddToCalendarButton({required this.sight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SightCardButton(
      icon: AppAssets.iconCalendar,
      sight: sight,
      onPressed: () async {
        final selectedDateTime = (Platform.isIOS)
            ? await _showIOSDateTimePicker(context: context)
            : await _showAndroidDateTimePicker(context: context);

        debugPrint('Выбрана дата посещения $sight: $selectedDateTime');
      },
    );
  }
}

Future<DateTime?> _showIOSDateTimePicker({
  required BuildContext context,
}) async {
  final theme = Theme.of(context);

  final selectedDateTime = await showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (context) {
      var currentDateTime = DateTime.now();

      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        height: 240,
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(currentDateTime);
                },
                child: Text(
                  'Выбрать',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                onDateTimeChanged: (value) {
                  currentDateTime = value;
                },
                initialDateTime: currentDateTime,
              ),
            ),
          ],
        ),
      );
    },
  );

  return selectedDateTime;
}

Future<DateTime?> _showAndroidDateTimePicker({
  required BuildContext context,
}) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.utc(2050),
  );
  if (selectedDate == null) {
    return null;
  }

  final selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (selectedTime == null) {
    return null;
  }

  return DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );
}

class _ShareButton extends StatelessWidget {
  final Place sight;

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
  final Place sight;
  final ValueChanged<Place>? onRemove;

  const _RemoveFromFavorites({
    required this.sight,
    Key? key,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SightCardButton(
      icon: AppAssets.iconRemove,
      sight: sight,
      onPressed: () {
        onRemove?.call(sight);
      },
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
      height: 96,
      width: double.infinity,
      constraints: const BoxConstraints(
        //maxHeight: 92,
        minWidth: double.infinity,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
    final theme = Theme.of(context);

    return Text(
      MockStrings.openingHours,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

// Виджет отображает имя интересного места в списке
class _SightCardName extends StatelessWidget {
  final Place sight;

  const _SightCardName({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      sight.name,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

// Виджет отображает тип интересного места в списке
class _SightCardType extends StatelessWidget {
  final Place sight;

  const _SightCardType({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      child: Text(
        sight.placeType.synonym(),
        style: theme.textTheme.titleSmall?.copyWith(
          color: AppColors.white,
        ),
      ),
      top: 16,
      left: 16,
    );
  }
}
