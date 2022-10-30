import 'package:flutter/material.dart';
import 'package:places/data/api/api.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';
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
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/onboarding': (_) => const OnboardingScreen(),
        '/list': (_) => const SightListScreen(),
        '/settings': (_) => const SettingsScreen(),
        '/visiting': (_) => const VisitingScreen(),
        '/map': (_) => const Scaffold(
              bottomNavigationBar: AppBottomNavigationBar(index: 1),
            ),
        '/search': (_) => const SearchScreen(),
        '/filter': (_) => const FiltersScreen(),
        '/add': (_) => const AddSightScreen(),
      },
    );
  }

  void updateTheme() {
    Provider.of<SettingsInteractor>(context).getTheme().then((isDarkTheme) {
      setState(() {
        _isDarkTheme = isDarkTheme;
      });
    });
  }
}
