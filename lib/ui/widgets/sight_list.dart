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
    return children.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) =>
                _CardInList(sightCard: children[index]),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: children.length,
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
