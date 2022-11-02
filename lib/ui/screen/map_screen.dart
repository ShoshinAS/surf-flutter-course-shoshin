import 'package:flutter/material.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(index: 1),
    );
  }
}
