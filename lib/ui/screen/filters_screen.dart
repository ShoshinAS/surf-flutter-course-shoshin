import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/filter.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/app_bar.dart';
import 'package:places/ui/screen/big_button.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/typography.dart';

class FiltersScreen extends StatefulWidget {
  static const sliderRange = RangeValues(100, 10000);

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Filter filter = Filter(
      sightList: mocks,
      startDistance: FiltersScreen.sliderRange.start,
      endDistance: FiltersScreen.sliderRange.end,
      selectedCategories: SightType.values.toSet(),
  );

  RangeValues selectedRange = FiltersScreen.sliderRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 56,
        leading: const ReturnButton(),
        actions: [
          _ClearFiltersButton(
            onPressed: () {
              setState(() {
                filter.clear();
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.categories,
                style: AppTypography.styleSuperSmall.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            //const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              children: SightType.values
                  .map(
                    (e) => _CategoryCard(
                      title: e.toString(),
                      icon: e.getIcon(),
                      selected: filter.selected(e),
                      onPressed: () {
                        setState(() {
                          filter.invert(e);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    AppStrings.distance,
                    style: AppTypography.styleText.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                ),
                Text(
                    AppStrings.distanceRange,
                    style: AppTypography.styleText.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                ),
              ],
            ),
            RangeSlider(
              values: RangeValues(filter.startDistance, filter.endDistance),
              min: FiltersScreen.sliderRange.start,
              max: FiltersScreen.sliderRange.end,
              activeColor: Theme.of(context).colorScheme.secondary,
              inactiveColor: Theme.of(context).colorScheme.outline,
              onChanged: (rangeValues) {
                setState(() {
                  filter.startDistance = rangeValues.start;
                  filter.endDistance = rangeValues.end;
                });
              },
            ),
            const Expanded(child: SizedBox.shrink()),
            BigButton(
              title: AppStrings.show,
              onPressed: () async {
                debugPrint(selectedRange.toString());
                await filter.determineCurrentLocation();
                filter.filter();
                debugPrint(filter.result.toString());
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _ClearFiltersButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ClearFiltersButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        AppStrings.clear,
        style: AppTypography.styleText.copyWith(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.background,
        onPrimary: Theme.of(context).colorScheme.onBackground,
      ).copyWith(
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                icon,
                color: Theme.of(context).colorScheme.secondary,
              ),
              if (selected)
                Positioned(
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        AppAssets.iconTickCircle,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      SvgPicture.asset(
                        AppAssets.iconTickChoice,
                        color: Theme.of(context).colorScheme.tertiary,
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
          const SizedBox(height: 12),
          Container(
            width: 96,
            height: 16,
            alignment: Alignment.center,
            child: Text(
              title,
              style: AppTypography.styleSuperSmall.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension _Category on SightType {
  String getIcon() {
    switch (this) {
      case SightType.hotel:
        return AppAssets.iconCategoryHotel;
      case SightType.restaurant:
        return AppAssets.iconCategoryRestaurant;
      case SightType.particular:
        return AppAssets.iconCategoryParticular;
      case SightType.park:
        return AppAssets.iconCategoryPark;
      case SightType.museum:
        return AppAssets.iconCategoryMuseum;
      case SightType.cafe:
        return AppAssets.iconCategoryCafe;
      default:
        return '';
    }
  }
}
