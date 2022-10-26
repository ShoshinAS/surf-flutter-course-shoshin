import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
import 'package:places/ui/screen/search_screen.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list.dart';
import 'package:provider/provider.dart';

// Виджет отображает экран со списком интересных мест
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  final Filter _filter = Filter(location: MockLocations.location3);

  late PlaceInteractor _placeInteractor;
  late Future<List<Place>> _futurePlaces;
  late Future<List<Place>> _futureFavorites;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _placeInteractor = Provider.of<PlaceInteractor>(context);
    updatePlaces();
    updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchBarFocusNode = FocusNode();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: theme.colorScheme.background,
              collapsedHeight: 56,
              expandedHeight: 128,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  AppStrings.appBarTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                expandedTitleScale: 1.8,
                centerTitle: true,
                titlePadding: const EdgeInsets.only(bottom: 16),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                SearchBar(
                  height: 52,
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  suffixIcon: _FilterButton(
                    filter: _filter,
                    onFilterChange: (newFilter) {
                      setState(() {
                        _filter.load(newFilter);
                        updatePlaces();
                      });
                    },
                  ),
                  focusNode: searchBarFocusNode,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/search',
                      arguments: SearchScreenArguments(filter: _filter),
                    );
                    searchBarFocusNode.unfocus();
                  },
                  keyboardType: TextInputType.none,
                ),
              ]),
            ),
            FutureBuilder<List<Place>>(
              future: _futurePlaces,
              builder: (context, snapshotPlaceList) {
                return FutureBuilder<List<Place>>(
                  future: _futureFavorites,
                  builder: (context, snapshotFavorites) {
                    final favoritesId = snapshotFavorites.hasData
                        ? snapshotFavorites.data!.map((e) => e.id).toSet()
                        : <String>{};

                    return SightList(
                      children: snapshotPlaceList.hasData
                          ? snapshotPlaceList.data!
                              .map(
                                (e) => SightCardInList(
                                  e,
                                  inFavorites: favoritesId.contains(e.id),
                                  onAddToFavorites: (place) {
                                    setState(() {
                                      _placeInteractor.addToFavorites(place);
                                      updateFavorites();
                                    });
                                  },
                                  onRemoveFromFavorites: (place) {
                                    setState(() {
                                      _placeInteractor.removeFromFavorites(place);
                                      updateFavorites();
                                    });
                                  },
                                ),
                              )
                              .toList()
                          : [],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(
        index: 0,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: _NewSightButton(onAddPlace: (newPlace) {
        setState(() {
          updatePlaces();
        });
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> updatePlaces() async {
    _futurePlaces = _placeInteractor.getPlaces(_filter);
  }

  Future<void> updateFavorites() async {
    _futureFavorites = _placeInteractor.getFavoritesPlaces();
  }
}

// кнопка перехода к экрану фильтрации
class _FilterButton extends StatelessWidget {
  final Filter filter;
  final ValueChanged<Filter> onFilterChange;

  const _FilterButton(
      {Key? key, required this.filter, required this.onFilterChange,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        constraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        icon: SvgPicture.asset(AppAssets.iconFilter),
        onPressed: () async {
          final newFilter = await Navigator.of(context).pushNamed(
            '/filter',
            arguments: FiltersScreenArguments(initialFilter: filter),
          ) as Filter?;
          if (newFilter != null) {
            onFilterChange(newFilter);
          }
        },
        splashRadius: 32,
      ),
    );
  }
}

// кнопка создания нового интересного места
class _NewSightButton extends StatelessWidget {
  final ValueChanged<Place> onAddPlace;

  const _NewSightButton({Key? key, required this.onAddPlace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonBorderRadius = BorderRadius.circular(24);
    final theme = Theme.of(context);
    final customColors = theme.extension<CustomColors>()!;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: buttonBorderRadius,
        ),
      ),
      child: Ink(
        width: 177,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: buttonBorderRadius,
          gradient: LinearGradient(
            colors: [
              customColors.gradient1!,
              customColors.gradient2!,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.iconPlus),
            const SizedBox(
              width: 8,
            ),
            Text(
              AppStrings.newPlace.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
      onPressed: () async {
        final newPlace = await Navigator.of(context).pushNamed('/add') as Place?;
        if (newPlace != null) {
          onAddPlace(newPlace);
        }
      },
    );
  }
}
