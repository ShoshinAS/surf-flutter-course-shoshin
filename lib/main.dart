import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      title: AppStrings.appTitle,
      //home: SightListScreen(sightList: mocks),
      //home: SightDetails(mocks[1]),
      home: const VisitingScreen(),
    );
  }
}
