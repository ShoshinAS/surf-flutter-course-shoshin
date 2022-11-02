import 'package:flutter/material.dart';
import 'package:places/data/api/api.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screen/res/router.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => PlaceInteractor(PlaceRepository(Api.dio()))),
      Provider(create: (_) => SearchInteractor(PlaceRepository(Api.dio()))),
      ChangeNotifierProvider(create: (_) => SettingsInteractor()),
    ],
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _isDarkTheme = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkTheme ? darkTheme : lightTheme,
      title: AppStrings.appTitle,
      initialRoute: AppRouter.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }

  void updateTheme() {
    context.watch<SettingsInteractor>().getTheme().then((isDarkTheme) {
      setState(() {
        _isDarkTheme = isDarkTheme;
      });
    });
  }
}
