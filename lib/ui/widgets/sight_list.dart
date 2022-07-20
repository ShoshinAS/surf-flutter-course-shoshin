import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/sight_card.dart';

typedef OnMoveElementCallback = void Function(
  Sight sourceElement,
  Sight? targetElement,
);

// виджет реализует список интересных мест
class SightList extends StatelessWidget {
  final List<SightCard> children;
  final Widget emptyScreen;
  final OnMoveElementCallback? onMoveElement;
  final ValueChanged<Sight>? onRemove;
  final bool editable;

  const SightList({
    Key? key,
    required this.children,
    this.emptyScreen = const Text(''),
    this.onMoveElement,
    this.onRemove,
    this.editable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return children.isNotEmpty
        ? (editable
            ? _EditableList(
                children: children,
                onRemove: onRemove,
                onMoveElement: onMoveElement,
              )
            : _List(children: children))
        : emptyScreen;
  }
}

class _EditableList extends StatefulWidget {
  final List<SightCard> children;
  final OnMoveElementCallback? onMoveElement;
  final ValueChanged<Sight>? onRemove;

  const _EditableList({
    Key? key,
    required this.children,
    this.onMoveElement,
    this.onRemove,
  }) : super(key: key);

  @override
  State<_EditableList> createState() => _EditableListState();
}

class _EditableListState extends State<_EditableList> {
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: widget.children
                .map(
                  (sightCard) => LongPressDraggable<Sight>(
                    feedback: sightCard,
                    child: DragTarget<Sight>(
                      builder: (context, candidateItems, rejectedItems) =>
                          _DismissibleCardInList(
                        sightCard: sightCard,
                        onDismissed: (direction) {
                          setState(() {
                            widget.onRemove?.call(sightCard.sight);
                          });
                        },
                      ),
                      onWillAccept: (sight) => true,
                      onAccept: (sight) {
                        widget.onMoveElement?.call(sight, sightCard.sight);
                      },
                    ),
                    childWhenDragging: const SizedBox.shrink(),
                    data: sightCard.sight,
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
                  ),
                )
                .toList(),
          ),
          // на время перетаскивания добавим в конец "пустое место", чтобы
          // пользователь мог перетащить карточку в конец списка
          if (isDragging)
            DragTarget<Sight>(
              builder: (context, candidateData, rejectedData) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: SizedBox(
                  height: 192,
                ),
              ),
              onWillAccept: (sight) => true,
              onAccept: (sight) {
                widget.onMoveElement?.call(sight, null);
              },
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  final List<SightCard> children;

  const _List({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: children
            .map(
              (sightCard) => _CardInList(sightCard: sightCard),
            )
            .toList(),
      ),
    );
  }
}

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

class _CardInList extends StatelessWidget {
  final SightCard sightCard;

  const _CardInList({Key? key, required this.sightCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: sightCard,
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
