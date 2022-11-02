import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:places/ui/widgets/sight_list_draggable.dart';
import 'package:provider/provider.dart';

// виджет отображает экран Хочу посетить / Интересные места
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.favoriteTitle,
          titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
          height: 108,
          bottom: const _CustomTabBar(
            height: 52,
            tabs: [
              Tab(
                text: AppStrings.wantToVisitTitle,
              ),
              Tab(
                text: AppStrings.visitedTitle,
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          _ScheduledList(),
          _VisitedList(),
        ]),
        bottomNavigationBar: const AppBottomNavigationBar(index: 2),
      ),
    );
  }
}

// виджет отображает пустой список экрана Хочу посетить / Интересные места
class _EmptyScreen extends StatelessWidget {
  final String iconAssetName;
  final String description;
  const _EmptyScreen({
    Key? key,
    required this.iconAssetName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: 253.5,
        height: 156,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SvgPicture.asset(
              iconAssetName,
              color: theme.colorScheme.outline,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.empty,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет реализует TapBar для отображения на экране Хочу посетить / Интересные места
class _CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> tabs;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const _CustomTabBar({
    Key? key,
    required this.tabs,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(40),
        ),
        child: TabBar(
          indicator: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(40),
          ),
          unselectedLabelColor: theme.colorScheme.onPrimaryContainer,
          unselectedLabelStyle: theme.textTheme.titleSmall,
          labelColor: theme.colorScheme.onPrimary,
          tabs: tabs,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
    );
  }
}

// Виджет, реализующий список мест, запланированных к посещению
class _ScheduledList extends StatefulWidget {
  const _ScheduledList({Key? key}) : super(key: key);

  @override
  State<_ScheduledList> createState() => _ScheduledListState();
}

class _ScheduledListState extends State<_ScheduledList> {
  late final PlaceInteractor _placeInteractor;
  late Future<List<Place>> _futureFavorites;

  @override
  void initState() {
    super.initState();
    _placeInteractor = context.read<PlaceInteractor>();
    updateFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
        future: _futureFavorites,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SightListDraggable(
                  children: snapshot.data!
                      .map((place) => SightCardInScheduledList(
                            place,
                            onRemove: (place) {
                              setState(() {
                                _placeInteractor.removeFromFavorites(place);
                                updateFavorites();
                              });
                            },
                          ))
                      .toList(),
                  emptyScreen: const _EmptyScreen(
                    iconAssetName: AppAssets.iconVisitedEmpty,
                    description: AppStrings.emptyVisitedDescription,
                  ),
                  onMoveElement: (sourceElement, targetElement) {
                    setState(() {
                      _placeInteractor.moveOnFavorites(sourceElement, targetElement);
                      updateFavorites();
                    });
                  },
                  onRemove: (place) {
                    setState(() {
                      _placeInteractor.removeFromFavorites(place);
                      updateFavorites();
                    });
                  },
                )
              : const SizedBox.shrink();
        },
    );
  }

  Future<void> updateFavorites() async {
    _futureFavorites = _placeInteractor.getFavoritesPlaces();
  }

}

// Виджет, реализующий список посещенных мест
class _VisitedList extends StatelessWidget {
  const _VisitedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeInteractor = context.read<PlaceInteractor>();
    final futureVisitedPlaces = placeInteractor.getVisitPlaces();

    return FutureBuilder<List<Place>>(
      future: futureVisitedPlaces,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? SightListDraggable(
                children: snapshot.data!
                    .toList()
                    .map((sight) => SightCardInVisitedList(
                          sight,
                          onRemove: (sight) {
                            snapshot.data!.remove(sight);
                          },
                        ))
                    .toList(),
                emptyScreen: const _EmptyScreen(
                  iconAssetName: AppAssets.iconVisitedEmpty,
                  description: AppStrings.emptyVisitedDescription,
                ),
                onMoveElement: (sourceElement, targetElement) {
                  //snapshot.data!.move(sourceElement, targetElement);
                },
                onRemove: (sight) {
                  snapshot.data!.remove(sight);
                },
              )
            : const SizedBox.shrink();
      },
    );
  }
}
