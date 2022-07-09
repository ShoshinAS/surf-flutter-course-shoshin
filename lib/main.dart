import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/models/filter_model.dart';
import 'package:places/ui/models/search_history_model.dart';
import 'package:places/ui/models/theme_model.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/res/values.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeModel()),
      ChangeNotifierProvider(create: (context) => Filter(maxDistance: AppValues.maxDistance, sightList: mocks)),
      ChangeNotifierProvider(create: (context) => SearchHistory()),
    ],
    child: const App(),
  ));
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
          home: const SightListScreen(),
        );
      },
    );
  }
}
