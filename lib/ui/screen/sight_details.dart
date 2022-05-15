import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
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
          SightImage(sight: sight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                SightDetailsName(sight: sight),
                const SizedBox(height: 2),
                Row(
                  children: [
                    SightDetailsType(sight: sight),
                    const SizedBox(width: 16),
                    const SightOpeningHours(),
                  ],
                ),
                const SizedBox(height: 24),
                SightDescription(sight: sight),
                const SizedBox(height: 24),
                const RouteButton(),
                const SizedBox(height: 24),
                const Divider(),
              ],
            ),
          ),
          const BottomPanel(),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

// Виджет отображает краткое описание интересного места на экране информации
class SightDescription extends StatelessWidget {
  final Sight sight;

  const SightDescription({
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
class SightOpeningHours extends StatelessWidget {
  const SightOpeningHours({
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
class SightDetailsType extends StatelessWidget {
  final Sight sight;

  const SightDetailsType({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.type,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );
  }
}

// Виджет отображает имя интересного места
class SightDetailsName extends StatelessWidget {
  final Sight sight;

  const SightDetailsName({
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
class BottomPanel extends StatelessWidget {
  const BottomPanel({
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
        children: const [
          BottomButton(
            text: AppStrings.plan,
            active: false,
            icon: AppAssets.iconCalendar,
          ),
          BottomButton(
            text: AppStrings.toFavourites,
            active: true,
            icon: AppAssets.iconHear,
          ),
        ],
      ),
    );
  }
}

// Виджет отображает изображение интересного места
// с кнопкой возврата на предыдущий экран
class SightImage extends StatelessWidget {
  final Sight sight;

  const SightImage({
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
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 32,
              width: 32,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppAssets.iconArrow,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
            ),
            left: 16,
            top: 36,
          ),
        ],
      ),
    );
  }
}

// Виджет отображает горизонтальную линию-разделитель
class Divider extends StatelessWidget {
  const Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 0.8,
          ),
        ),
      ),
    );
  }
}

// Виджет отображает кнопку построения маршрута до интересного места
class RouteButton extends StatelessWidget {
  const RouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.iconGo,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 10),
          Text(
            AppStrings.route,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

// Виджет отображает кнопки в нижней панели экрана
class BottomButton extends StatelessWidget {
  final String text;
  final bool active;
  final String icon;

  const BottomButton({
    required this.text,
    required this.active,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = active
        ? Theme.of(context).colorScheme.onBackground
        : Theme.of(context).colorScheme.outline;

    return Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              color: color,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
