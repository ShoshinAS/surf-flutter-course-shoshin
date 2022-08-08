import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/models/favourites_model.dart';
import 'package:places/ui/models/filter_model.dart';
import 'package:places/ui/models/search_history_model.dart';
import 'package:places/ui/models/theme_model.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/res/values.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeModel()),
      ChangeNotifierProvider(
        create: (_) =>
            Filter(maxDistance: AppValues.maxDistance, sightList: mocks),
      ),
      ChangeNotifierProvider(create: (_) => SearchHistory()),
      ChangeNotifierProvider(create: (_) => VisitedSights(visitedSights)),
      ChangeNotifierProvider(create: (_) => ScheduledSights(scheduledSights)),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<Filter>(context);

    return Consumer<ThemeModel>(
      builder: (context, model, child) {
        return MaterialApp(
          theme: model.darkTheme ? darkTheme : lightTheme,
          title: AppStrings.appTitle,
          initialRoute: '/splash',
          routes: {
            '/splash': (_) => const SplashScreen(),
            '/onboarding': (_) => const OnboardingScreen(),
            '/list': (_) => const SightListScreen(),
            '/details': (_) => const SightDetailsScreen(),
            '/settings': (_) => const SettingsScreen(),
            '/visiting': (_) => const VisitingScreen(),
            '/map': (_) => const Scaffold(
                  bottomNavigationBar: AppBottomNavigationBar(index: 1),
                ),
            '/search': (_) => const SearchScreen(),
            '/filter': (_) => FiltersScreen(initialFilter: filter),
            '/add': (_) => const AddSightScreen(),
          },
        );
      },
    );
  }
}
