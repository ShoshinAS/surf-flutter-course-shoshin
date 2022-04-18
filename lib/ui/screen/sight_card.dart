import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/typography.dart';

// Виджет отображает карточку интересного места в списке
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SightCardImage(sight: sight),
                SightCardType(sight: sight),
                const SightCardAddToFavorites(),
              ],
            ),
          ),
          Expanded(
            child: SightCardDescription(sight: sight),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Виджет отображает блок текстового описания интересного места в списке
class SightCardDescription extends StatelessWidget {
  final Sight sight;

  const SightCardDescription({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 92,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.sightCardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          SightCardName(sight: sight),
          const SizedBox(height: 2),
          SightCardDetails(sight: sight),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Виджет отображает краткое описание интересного места в списке
class SightCardDetails extends StatelessWidget {
  final Sight sight;

  const SightCardDetails({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        sight.details,
        style: AppTypography.styleSmall,
        overflow: TextOverflow.fade,
        maxLines: 3,
      ),
    );
  }
}

// Виджет отображает имя интересного места в списке
class SightCardName extends StatelessWidget {
  final Sight sight;

  const SightCardName({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.name,
      style: AppTypography.styleText,
    );
  }
}

// Виджет отображает кнопку добавления в избранное
class SightCardAddToFavorites extends StatelessWidget {
  const SightCardAddToFavorites({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: AppColors.sightCardColor,
        width: 20,
        height: 18,
      ),
      top: 19,
      right: 18,
    );
  }
}

// Виджет отображает тип интересного места в списке
class SightCardType extends StatelessWidget {
  final Sight sight;

  const SightCardType({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Text(
        sight.type,
        style: AppTypography.styleSmallBoldWhite,
      ),
      top: 16,
      left: 16,
    );
  }
}

// Виджет отображает картинку интересного места в списке
class SightCardImage extends StatelessWidget {
  final Sight sight;

  const SightCardImage({
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
