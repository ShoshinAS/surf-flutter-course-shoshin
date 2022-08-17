import 'package:flutter/material.dart';
import 'package:places/ui/widgets/sight_card.dart';

// виджет реализует список интересных мест
class SightList extends StatelessWidget {
  final List<SightCard> children;
  final Widget emptyScreen;

  const SightList({
    Key? key,
    required this.children,
    this.emptyScreen = const Text(''),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return children.isNotEmpty
        ? SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: portrait ? 1 : 2,
              mainAxisExtent: 220,
              crossAxisSpacing: 36,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _CardInList(sightCard: children[index]),
              childCount: children.length,
            ),
          )
        : emptyScreen;
  }
}

// виджет, реализующий карточку в списке без возможности смахивания
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
