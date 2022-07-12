import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight_type.dart';
import 'package:places/ui/models/filter_model.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/big_button.dart';

// экран фильтра
class FiltersScreen extends StatefulWidget {
  final Filter initialFilter;

  const FiltersScreen({Key? key, required this.initialFilter}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late final Filter screenFilter;

  @override
  void initState() {
    super.initState();
    screenFilter = Filter.from(widget.initialFilter);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: CustomAppBar(
          height: 56,
          leading: const ReturnButton(),
          actions: [
            _ClearFiltersButton(
              onPressed: () {
                setState(screenFilter.clear);
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
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
              //const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                children: SightType.values
                    .map(
                      (e) =>
                      _CategoryCard(
                        title: e.toString(),
                        icon: e.getIcon(),
                        selected: screenFilter.selected(e),
                        onPressed: () {
                          setState(() {
                            screenFilter.invert(e);
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
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onTertiary,
                    ),
                  ),
                  Text(
                    'до ${(screenFilter.selectedDistance / 1000).toStringAsFixed(
                        2,)} км',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              Slider(
                value: screenFilter.selectedDistance,
                max: screenFilter.maxDistance,
                activeColor: theme.colorScheme.secondary,
                inactiveColor: theme.colorScheme.outline,
                onChanged: (newValue) {
                  setState(() {
                    screenFilter.selectedDistance = newValue;
                  });
                },
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: BigButton(
            active: screenFilter.amount > 0,
            title: '${AppStrings.show} (${screenFilter.amount})',
            onPressed: () {
              widget.initialFilter.fill(screenFilter);
              Navigator.pop(context);
            },
          ),
        ),
      );
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
