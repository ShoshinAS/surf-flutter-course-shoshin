import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place_type.dart';
import 'package:places/ui/models/place_type_synonym.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/big_button.dart';
import 'package:provider/provider.dart';

class FiltersScreenArguments {
  final Filter initialFilter;

  FiltersScreenArguments({required this.initialFilter});
}

// экран фильтра
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late final Filter _filter;

  late PlaceInteractor _placeInteractor;

  CancelableOperation<void>? _updateAmountOperation;
  int? _amount;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _placeInteractor = Provider.of<PlaceInteractor>(context);
    final args = ModalRoute.of(context)!.settings.arguments as FiltersScreenArguments;
    _filter = Filter.from(args.initialFilter);
    updateAmount();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final smallScreen = MediaQuery.of(context).size.height <= 600;
    final categoriesCrossAxisCount = smallScreen ? 1 : 2;
    final categoriesHeight = 92 * categoriesCrossAxisCount.toDouble() +
        40 * (categoriesCrossAxisCount.toDouble() - 1);

    return Scaffold(
      appBar: CustomAppBar(
        height: 56,
        leading: const ReturnButton(),
        actions: [
          _ClearFiltersButton(
            onPressed: () {
              setState(() {
                _filter.clear();
                delayedUpdateAmount();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.categories,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: categoriesHeight,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: categoriesCrossAxisCount,
                shrinkWrap: true,
                children: PlaceType.values
                    .map(
                      (e) => _CategoryCard(
                        title: e.synonym(),
                        icon: e.getIcon(),
                        selected: _filter.typeSelected(e),
                        onPressed: () {
                          setState(() {
                            _filter.invertTypeSelection(e);
                            delayedUpdateAmount();
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.distance,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onTertiary,
                  ),
                ),
                Text(
                  '${AppStrings.upTo} ${(_filter.radius / 1000).toStringAsFixed(
                    2,
                  )} ${AppStrings.km}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
            Slider(
              value: _filter.radius,
              max: Filter.maxRadius,
              activeColor: theme.colorScheme.secondary,
              inactiveColor: theme.colorScheme.outline,
              onChanged: (newValue) {
                setState(() {
                  _filter.radius = newValue;
                  delayedUpdateAmount();
                });
              },
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: BigButton(
          active: (_amount != null) && (_amount! > 0),
          title: (_amount != null)
              ? '${AppStrings.show} ($_amount)'
              : AppStrings.show,
          onPressed: () {
            Navigator.pop(context, _filter);
          },
        ),
      ),
    );
  }

  Future<void> updateAmount() async {
    final placeList = await _placeInteractor.getPlaces(_filter);
    setState(() {
      _amount = placeList.length;
    });
  }

  void delayedUpdateAmount() {
    _updateAmountOperation?.cancel();
    _updateAmountOperation = CancelableOperation<void>.fromFuture(
      Future.delayed(const Duration(seconds: 1), () {}),
    );
    _updateAmountOperation!.value.whenComplete(updateAmount);
  }
}

// виджет кнопки очистки фильтра
class _ClearFiltersButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ClearFiltersButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextButton(
      onPressed: onPressed,
      child: Text(
        AppStrings.clear,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}

// кнопка выбора категории
class _CategoryCard extends StatelessWidget {
  final String icon;
  final String title;
  final bool selected;
  final VoidCallback onPressed;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: theme.colorScheme.background,
            onPrimary: theme.colorScheme.onBackground,
            shape: const CircleBorder(),
          ).copyWith(
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: onPressed,
          child: Stack(
            children: [
              SvgPicture.asset(
                icon,
                color: theme.colorScheme.secondary,
              ),
              if (selected)
                Positioned(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        AppAssets.iconTickCircle,
                        color: theme.colorScheme.onTertiary,
                      ),
                      SvgPicture.asset(
                        AppAssets.iconTickChoice,
                        color: theme.colorScheme.tertiary,
                      ),
                    ],
                  ),
                  right: 0,
                  bottom: 0,
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 96,
          height: 16,
          alignment: Alignment.center,
          child: Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}

// расширение SightType для определения иконки для каждой категории
extension _Category on PlaceType {
  String getIcon() {
    switch (this) {
      case PlaceType.hotel:
        return AppAssets.iconCategoryHotel;
      case PlaceType.restaurant:
        return AppAssets.iconCategoryRestaurant;
      case PlaceType.particular:
        return AppAssets.iconCategoryParticular;
      case PlaceType.park:
        return AppAssets.iconCategoryPark;
      case PlaceType.museum:
        return AppAssets.iconCategoryMuseum;
      case PlaceType.cafe:
        return AppAssets.iconCategoryCafe;
      default:
        return '';
    }
  }
}
