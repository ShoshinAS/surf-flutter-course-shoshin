import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/blocs/favourite_places/favourite_places_bloc.dart';
import 'package:places/blocs/visited_places/visited_places_bloc.dart';
import 'package:places/data/api/api.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/data/repository/user_data_repository.dart';
import 'package:places/ui/screen/res/router.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:provider/provider.dart';

void main() {
  final dio = Api.dio();
  final placeRepository = PlaceRepository(dio);
  final userDataRepository = UserDataRepository();
  final placeInteractor = PlaceInteractor(placeRepository, userDataRepository);
  final searchInteractor = SearchInteractor(placeRepository);
  final settingsInteractor = SettingsInteractor();

  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => PlaceRepository(Api.dio())),
      Provider(create: (_) => placeRepository),
      Provider(create: (_) => userDataRepository),
      Provider(create: (_) => placeInteractor),
      Provider(create: (_) => searchInteractor),
      ChangeNotifierProvider(create: (_) => settingsInteractor),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider<FavouritePlacesBloc>(
          create: (context) => FavouritePlacesBloc(
            userDataRepository: context.read<UserDataRepository>(),
          ),
        ),
        BlocProvider<VisitedPlacesBloc>(
          create: (context) => VisitedPlacesBloc(
            userDataRepository: context.read<UserDataRepository>(),
          ),
        ),
      ],
      child: const App(),
    ),
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
