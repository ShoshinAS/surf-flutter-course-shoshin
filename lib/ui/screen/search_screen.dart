import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/search.dart';
import 'package:places/ui/models/search_history_model.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/colors.dart';
import 'package:places/ui/screen/res/strings.dart';
import 'package:places/ui/screen/sight_details_screen.dart';
import 'package:places/ui/widgets/app_bar.dart';
import 'package:places/ui/widgets/clear_text_button.dart';
import 'package:places/ui/widgets/empty_state.dart';
import 'package:places/ui/widgets/network_image.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:provider/provider.dart';

// экран поиска интересных мест
class SearchScreen extends StatefulWidget {
  final List<Sight> sightList;
  const SearchScreen({Key? key, required this.sightList}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();

  late final Search _search;

  bool _resizeToAvoidBottomInset = true;

  @override
  void initState() {
    super.initState();
    _search = Search(sightList: widget.sightList);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchHistory = Provider.of<SearchHistory>(context);

    final Widget content;

    if (_controller.text.isEmpty) {
      content = searchHistory.isEmpty
          ? const SizedBox.shrink()
          : _SearchHistory(
              queries: searchHistory.toList(),
              onDelete: (query) {
                searchHistory.remove(query);
                setState(() {});
              },
              onClear: () {
                searchHistory.clear();
                setState(() {});
              },
              onTap: (query) {
                _controller
                  ..text = query
                  ..selection = TextSelection.collapsed(offset: query.length);
                _search.find(query, onFinish: () {
                  setState(() {});
                });
                searchHistory.add(query);
                setState(() {});
              },);
      _resizeToAvoidBottomInset = false;
    } else if (_search.status == SearchStatus.inProgress) {
      content = const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
      _resizeToAvoidBottomInset = true;
    } else if (_search.status == SearchStatus.finished) {
      if (_search.result.isEmpty) {
        content = const EmptyState(
          icon: AppAssets.iconSearch,
          titleText: AppStrings.nothingFound,
          subtitleText: AppStrings.tryToChangeSearchParameters,
        );
        _resizeToAvoidBottomInset = true;
      } else {
        content = _SearchResults(
          searchWords: _search.words,
          searchResults: _search.result,
          onTap: (sight) {
            Navigator.of(context).push<MaterialPageRoute>(
              MaterialPageRoute(
                builder: (context) => SightDetailsScreen(sight),
              ),
            );
            searchHistory.add(_controller.text);
          },
        );
        _resizeToAvoidBottomInset = false;
      }
    } else {
      content = const EmptyState(
        icon: AppAssets.iconDelete,
        titleText: AppStrings.error,
        subtitleText: AppStrings.somethingWentWrong,
      );
      _resizeToAvoidBottomInset = true;
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: CustomAppBar(
        title: AppStrings.appBarTitle,
        height: 108,
        titleTextStyle: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.onBackground,
        ),
        bottom: SearchBar(
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
              _search.find(
                query,
                onFinish: () {
                  setState(() {});
                },
              );
              setState(() {});
            } else if (query.isEmpty) {
              setState(() {});
            }
          },
          onSubmitted: (query) {
            _search.find(
              query,
              onFinish: () {
                setState(() {});
              },
            );
            searchHistory.add(query);
            setState(() {});
          },
        ),
      ),
      resizeToAvoidBottomInset: _resizeToAvoidBottomInset,
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
}

// виджет истории поиска на экране
class _SearchHistory extends StatelessWidget {
  final List<String> queries;
  final ValueChanged<String> onDelete;
  final Function(String) onTap;
  final VoidCallback onClear;

  const _SearchHistory({
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
        Column(
          children: queries
              .map((e) => _SearchQuery(
                    query: e,
                    onDelete: onDelete,
                    onTap: onTap,
                  ))
              .toList(),
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
  final List<Sight> searchResults;
  final Function(Sight)? onTap;

  const _SearchResults({
    Key? key,
    required this.searchWords,
    required this.searchResults,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: searchResults
          .map(
            (e) => _SearchResult(
              searchWords: searchWords,
              sight: e,
              onTap: onTap,
            ),
          )
          .toList(),
    );
  }
}

// виджет отображающий карточку интересного мест в результатах поиска
class _SearchResult extends StatelessWidget {
  final List<String> searchWords;
  final Sight sight;
  final Function(Sight)? onTap;

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
                _SearchResultImage(url: sight.url),
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
                        sight.type.toString(),
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
