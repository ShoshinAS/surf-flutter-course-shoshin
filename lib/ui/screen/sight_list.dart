import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightList extends StatelessWidget {
  final List<SightCard> children;
  final Widget emptyScreen;

  const SightList({
    Key? key,
    this.children = const [],
    this.emptyScreen = const Text(''),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: children.isNotEmpty
          ? SingleChildScrollView(child: Column(children: children))
          : emptyScreen,
    );
  }
}
