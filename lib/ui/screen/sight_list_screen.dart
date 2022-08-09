import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/models/filter_model.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/res/themes.dart';
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
  final FocusNode _searchBarFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<Filter>(
      builder: (context, filter, child) {
        return Scaffold(
          backgroundColor: theme.colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(slivers: [
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
                    suffixIcon: _FilterButton(filter: filter),
                    focusNode: _searchBarFocusNode,
                    onTap: () {
                      Navigator.of(context).pushNamed('/search');
                      _searchBarFocusNode.unfocus();
                    },
                    keyboardType: TextInputType.none,
                  ),
                ]),
              ),
              SightList(
                children: filter.result.map(SightCardInList.new).toList(),
              ),
            ]),
          ),
          bottomNavigationBar: const AppBottomNavigationBar(index: 0,),
          resizeToAvoidBottomInset: false,
          floatingActionButton: const _NewSightButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

// кнопка перехода к экрану фильтрации
class _FilterButton extends StatelessWidget {
  final Filter filter;

  const _FilterButton({Key? key, required this.filter}) : super(key: key);

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
        onPressed: () {
          Navigator.of(context).pushNamed('/filter');
        },
        splashRadius: 32,
      ),
    );
  }
}

// кнопка создания нового интересного места
class _NewSightButton extends StatelessWidget {
  const _NewSightButton({Key? key}) : super(key: key);

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
      onPressed: () {
        Navigator.of(context).pushNamed('/add');
      },
    );
  }
}
