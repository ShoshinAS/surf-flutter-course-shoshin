import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/sight_card.dart';

typedef OnMoveElementCallback = void Function(
    Place sourceElement,
    Place? targetElement,
);

// виджет реализует список интересных мест
class SightListDraggable extends StatefulWidget {
  final List<SightCard> children;
  final Widget emptyScreen;
  final OnMoveElementCallback? onMoveElement;
  final ValueChanged<Place>? onRemove;

  const SightListDraggable({
    Key? key,
    required this.children,
    this.emptyScreen = const Text(''),
    required this.onMoveElement,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<SightListDraggable> createState() => _SightListDraggableState();
}

class _SightListDraggableState extends State<SightListDraggable> {
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return widget.children.isNotEmpty
        ? ListView.builder(
            itemCount: widget.children.length + 1,
            itemBuilder: (context, index) {
              if (index == widget.children.length) {
                return isDragging
                    ? _EmptyDragTarget(onAccept: (sight) {
                        widget.onMoveElement?.call(sight, null);
                      })
                    : const SizedBox.shrink();
              } else {
                final sightCard = widget.children[index];

                return _CardInList(
                  sightCard: sightCard,
                  onDismissed: (direction) {
                    setState(() {
                      widget.onRemove?.call(sightCard.sight);
                    });
                  },
                  onAccept: (sight) {
                    widget.onMoveElement?.call(sight, sightCard.sight);
                  },
                  onDragStarted: () {
                    setState(() {
                      isDragging = true;
                    });
                  },
                  onDragEnd: (details) {
                    setState(() {
                      isDragging = false;
                    });
                  },
                );
              }
            },
            padding: const EdgeInsets.symmetric(horizontal: 16),
          )
        : widget.emptyScreen;
  }
}

// виджет, реализующий пустое место в конце списка для возможности перетаскивания
// в конец списка
class _EmptyDragTarget extends StatelessWidget {
  final DragTargetAccept<Place> onAccept;

  const _EmptyDragTarget({Key? key, required this.onAccept}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Place>(
      builder: (context, candidateData, rejectedData) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: SizedBox(
          height: 192,
        ),
      ),
      onWillAccept: (sight) => true,
      onAccept: onAccept,
    );
  }
}

// виджет, реализующий карточку в списке с возможностью интерактивного изменения
// списка (удаления, сортировки)
class _CardInList extends StatelessWidget {
  final SightCard sightCard;
  final DismissDirectionCallback onDismissed;
  final DragTargetAccept<Place> onAccept;
  final VoidCallback onDragStarted;
  final DragEndCallback onDragEnd;

  const _CardInList({
    Key? key,
    required this.sightCard,
    required this.onDismissed,
    required this.onAccept,
    required this.onDragStarted,
    required this.onDragEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Place>(
      feedback: sightCard,
      child: DragTarget<Place>(
        builder: (context, candidateItems, rejectedItems) =>
            _DismissibleCardInList(
          sightCard: sightCard,
          onDismissed: onDismissed,
        ),
        onWillAccept: (sight) => true,
        onAccept: onAccept,
      ),
      childWhenDragging: const SizedBox.shrink(),
      data: sightCard.sight,
      onDragStarted: onDragStarted,
      onDragEnd: onDragEnd,
    );
  }
}

// виджет, реализующий карточку в списке с возможностью смахивания
class _DismissibleCardInList extends StatelessWidget {
  final SightCard sightCard;
  final DismissDirectionCallback onDismissed;

  const _DismissibleCardInList({
    Key? key,
    required this.sightCard,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: [
          const Positioned.fill(
            child: _DismissibleBackground(),
          ),
          Dismissible(
            key: ValueKey(sightCard),
            child: sightCard,
            direction: DismissDirection.endToStart,
            onDismissed: onDismissed,
          ),
        ],
      ),
    );
  }
}

// фоновый виджет для dismissible
class _DismissibleBackground extends StatelessWidget {
  const _DismissibleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.colorScheme.error,
      ),
      margin: const EdgeInsets.all(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.iconBucket,
              color: AppColors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppStrings.delete,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
