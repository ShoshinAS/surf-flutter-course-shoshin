import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/models/place_type_synonym.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/clear_text_button.dart';
import 'package:places/ui/widgets/empty_state.dart';
import 'package:places/ui/widgets/error_placeholder.dart';
import 'package:places/ui/widgets/network_image.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/sight_details_bottomsheet.dart';
import 'package:provider/provider.dart';

class SearchScreenArguments {
  final Filter filter;

  SearchScreenArguments({required this.filter});
}

// экран поиска интересных мест
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  late final Filter _filter;

  late SearchInteractor _searchInteractor;

  Future<List<Place>>? _futurePlaceList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _searchInteractor = Provider.of<SearchInteractor>(context);
    final args = ModalRoute.of(context)!.settings.arguments as SearchScreenArguments;
    _filter = args.filter;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Widget content;

    content = _controller.text.isEmpty
        ? _SearchHistoryBuilder(onTap: (query) {
            _controller
              ..text = query
              ..selection = TextSelection.collapsed(offset: query.length);
            _search(query);
          })
        : FutureBuilder<List<Place>>(
            future: _futurePlaceList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isEmpty
                    ? Expanded(
                        child: EmptyState(
                          icon: AppAssets.iconSearch,
                          titleText: AppStrings.nothingFound,
                          subtitleText: AppStrings.tryToChangeSearchParameters,
                          titleColor: theme.colorScheme.outline,
                          subtitleColor: theme.colorScheme.outline,
                          iconHeight: 64,
                          iconWidth: 64,
                        ),
                      )
                    : _SearchResults(
                        searchWords: _controller.text
                            .split(' ')
                            .where((element) => element.isNotEmpty)
                            .toList(),
                        searchResults: snapshot.data!,
                        onTap: (sight) {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) =>
                                SightDetailsBottomSheet(
                                  sightId: sight.id,
                                ),
                          );
                        },
                      );
              } else if (snapshot.hasError) {
                return const Expanded(
                  child: ErrorPlaceholder(),
                );
              } else {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: AppStrings.appBarTitle,
        height: 108,
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onBackground,
        ),
        bottom: SearchBar(
          height: 52,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          autofocus: true,
          suffixIcon: ClearTextButton(
            controller: _controller,
            onClear: () {
              setState(() {});
            },
          ),
          focusNode: _focusNode,
          controller: _controller,
          onTap: () {
            setState(() {});
          },
          onChanged: (query) {
            if (query.endsWith(' ')) {
              _search(query);
            } else if (query.isEmpty) {
              setState(() {});
            }
          },
          onSubmitted: _search,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 32),
            content,
          ],
        ),
      ),
    );
  }

  Future<void> _search(String query) async {
    setState(() {
      _filter.nameFilter = query;
      _futurePlaceList = _searchInteractor.searchPlaces(_filter);
    });
  }
}

class _SearchHistoryBuilder extends StatefulWidget {
  final ValueChanged<String> onTap;

  const _SearchHistoryBuilder({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<_SearchHistoryBuilder> createState() => _SearchHistoryBuilderState();
}

class _SearchHistoryBuilderState extends State<_SearchHistoryBuilder> {
  late SearchInteractor _searchInteractor;
  late Future<List<String>> _futureSearchHistory;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _searchInteractor = Provider.of<SearchInteractor>(context);
    _futureSearchHistory = _searchInteractor.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _futureSearchHistory,
      builder: (context, snapshot) {
        return snapshot.hasData & (snapshot.data?.isNotEmpty ?? false)
            ? _SearchHistoryList(
                queries: snapshot.data!.toList(),
                onDelete: (query) async {
                  await _searchInteractor.removeFromHistory(query);
                  setState(() {});
                },
                onClear: () async {
                  await _searchInteractor.clearHistory();
                  setState(() {});
                },
                onTap: widget.onTap,
              )
            : const SizedBox.shrink();
      },
    );
  }
}

// виджет истории поиска на экране
class _SearchHistoryList extends StatelessWidget {
  final List<String> queries;
  final ValueChanged<String> onDelete;
  final Function(String) onTap;
  final VoidCallback onClear;

  const _SearchHistoryList({
    Key? key,
    required this.queries,
    required this.onDelete,
    required this.onTap,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.youSearched,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 250,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: queries.length,
            itemBuilder: (context, index) => _SearchQuery(
              query: queries[index],
              onDelete: onDelete,
              onTap: onTap,
            ),
          ),
        ),
        TextButton(
          onPressed: onClear,
          child: Text(
            AppStrings.clearHistory,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}

// виджет реализующий отображение поискового запроса в истории поиска
class _SearchQuery extends StatelessWidget {
  final String query;
  final ValueChanged<String> onDelete;
  final Function(String) onTap;

  const _SearchQuery({
    Key? key,
    required this.query,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 32,
                ),
                child: Material(
                  color: AppColors.transparent,
                  child: InkWell(
                    onTap: () {
                      onTap(query);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        query,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                onDelete(query);
              },
              icon: SvgPicture.asset(AppAssets.iconDelete),
              splashRadius: 16,
              constraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
            ),
          ],
        ),
        const Divider(height: 8),
      ],
    );
  }
}

// виджет отображающий результаты поиска
class _SearchResults extends StatelessWidget {
  final List<String> searchWords;
  final List<Place> searchResults;
  final Function(Place)? onTap;

  const _SearchResults({
    Key? key,
    required this.searchWords,
    required this.searchResults,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return _SearchResult(
            searchWords: searchWords,
            sight: searchResults[index],
            onTap: onTap,
          );
        },
      ),
    );
  }
}

// виджет отображающий карточку интересного мест в результатах поиска
class _SearchResult extends StatelessWidget {
  final List<String> searchWords;
  final Place sight;
  final Function(Place)? onTap;

  const _SearchResult({
    Key? key,
    required this.searchWords,
    required this.sight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onTertiary,
      fontWeight: FontWeight.w400,
    );
    final textStyleHighlight = textStyle.copyWith(
      fontWeight: FontWeight.w500,
    );

    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                _SearchResultImage(url: sight.coverURL),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HighlightedText(
                        sourceString: sight.name,
                        searchWords: searchWords,
                        style: textStyle,
                        highlightStyle: textStyleHighlight,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sight.placeType.synonym(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                color: AppColors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  onTap: () {
                    onTap?.call(sight);
                  },
                ),
              ),
            ),
          ],
        ),
        Divider(
          height: 11,
          indent: 72,
          color: theme.colorScheme.outline,
          thickness: 0.8,
        ),
      ],
    );
  }
}

// виджет отображающий картинку интересного места в результатах поиска
class _SearchResultImage extends StatelessWidget {
  final String url;

  const _SearchResultImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CustomImage(
        url,
        width: 56,
        height: 56,
      ),
    );
  }
}

// виджет отображающий заголовок интересного места с подсветкой
// фрагментов слов поискового запроса
class _HighlightedText extends StatelessWidget {
  final String sourceString;
  final List<String> searchWords;
  final TextStyle style;
  final TextStyle highlightStyle;

  const _HighlightedText({
    Key? key,
    required this.sourceString,
    required this.searchWords,
    required this.style,
    required this.highlightStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var index = 0;

    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: _occurrenceMask(sourceString, searchWords).map((e) {
          final textSpan = TextSpan(
            text: sourceString[index],
            style: e ? highlightStyle : style,
          );
          ++index;

          return textSpan;
        }).toList(),
      ),
    );
  }
}

// маска для подсветки фрагментов слов поискового запроса
List<bool> _occurrenceMask(String sourceString, List<String> searchWords) {
  final result = List.generate(sourceString.length, (index) => false);

  if (searchWords.isEmpty) {
    return result;
  }

  for (final word in searchWords) {
    var start = 0;
    while (true) {
      final index =
          sourceString.toLowerCase().indexOf(word.toLowerCase(), start);
      if (index == -1) {
        break;
      } else {
        result.fillRange(index, index + word.length, true);
        start = index + word.length;
      }
    }
  }

  return result;
}
