import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/models/theme_model.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeModel(), child: const App(),),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, model, child) {
        return MaterialApp(
          theme: model.darkTheme ? darkTheme : lightTheme,
          //theme: darkTheme,
          title: AppStrings.appTitle,
          //home: SightListScreen(sightList: mocks),
          //home: SightDetails(mocks[1]),
          //home: const VisitingScreen(),
          home: const FiltersScreen(),
          //home: const SettingsScreen(),
        );
      },
    );
  }
}
