import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  final int searchHistoryLength;
  final String title;
  final Widget Function(BuildContext, String?)
      builder; // results builder taking searched term as argument

  const SearchBar(
      {Key? key,
      this.searchHistoryLength = 5,
      this.title = 'Search',
      required this.builder})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final int _searchHistoryLength;

  final List<String> _searchHistory = [];
  late List<String> filteredSearchHistory;

  String? selectedTerm;

  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    _searchHistoryLength = widget.searchHistoryLength;
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  List<String> filterSearchTerms({required String? filter}) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    }
    return _searchHistory.reversed.toList();
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term); // don't let duplicates
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > _searchHistoryLength) {
      _searchHistory.removeRange(
          0,
          _searchHistory.length -
              _searchHistoryLength); // remove too many elements
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void removeSearchTerm(String term) {
    _searchHistory.remove(term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    removeSearchTerm(term);
    addSearchTerm(term);
  }

  void submitQuery(String query) {
    setState(() {
      addSearchTerm(query);
      selectedTerm = query;
    });
    controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: Builder(
            builder: (context) {
              final fsb = FloatingSearchBar.of(context)?.widget;
              return Padding(
                padding: EdgeInsets.only(top: fsb!.height * 1.1),
                child: widget.builder(context, selectedTerm),
              );
            },
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(
          selectedTerm ?? widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Write search term',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          submitQuery(query);
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Builder(
              builder: (context) {
                if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Start searching',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                } else if (filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(
                      controller.query,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      submitQuery(controller.query);
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1.2,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  removeSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              submitQuery(term);
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
