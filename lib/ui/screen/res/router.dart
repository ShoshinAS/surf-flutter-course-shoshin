import 'package:flutter/material.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/map_screen.dart';
import 'package:places/ui/screen/onboarding_screen.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/visiting_screen.dart';

abstract class AppRouter {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String list = '/list';
  static const String settings = '/settings';
  static const String visiting = '/visiting';
  static const String map = '/map';
  static const String search = '/search';
  static const String filter = '/filter';
  static const String add = '/add';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouter.splash:
        return MaterialPageRoute<Object?>(
          builder: (_) => const SplashScreen(),
        );
      case AppRouter.onboarding:
        final args = settings.arguments! as OnboardingScreenArguments;

        return MaterialPageRoute<Object?>(
          builder: (_) => OnboardingScreen(startedByUser: args.startedByUser),
        );
      case AppRouter.list:
        return MaterialPageRoute<Object?>(
          builder: (_) => const SightListScreen(),
        );
      case AppRouter.settings:
        return MaterialPageRoute<Object?>(
          builder: (_) => const SettingsScreen(),
        );
      case AppRouter.visiting:
        return MaterialPageRoute<Object?>(
          builder: (_) => const VisitingScreen(),
        );
      case AppRouter.map:
        return MaterialPageRoute<Object?>(
          builder: (_) => const MapScreen(),
        );
      case AppRouter.search:
        final args = settings.arguments! as SearchScreenArguments;

        return MaterialPageRoute<Object?>(
          builder: (_) => SearchScreen(filter: args.filter),
        );
      case AppRouter.filter:
        final args = settings.arguments! as FiltersScreenArguments;

        return MaterialPageRoute<Object?>(
          builder: (_) => FiltersScreen(initialFilter: args.initialFilter),
        );
      case AppRouter.add:
        return MaterialPageRoute<Object?>(
          builder: (_) => const AddSightScreen(),
        );
      default:
        return MaterialPageRoute<Object?>(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}