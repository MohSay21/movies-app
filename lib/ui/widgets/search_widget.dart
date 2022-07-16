import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/providers/search_provider.dart';
import 'package:movies_app/services/theme.dart';

class SearchWidget extends ConsumerWidget {

  SearchWidget({Key? key}) : super(key: key);

  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchHistory = ref.watch(searchHistoryProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Search for movies/series...',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _search(context, ref, searchCtrl.text),
              ),
            ),
            onSubmitted: (String text) => _search(context, ref, text),
            style: const TextStyle(),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: searchHistory.length,
              itemBuilder: (BuildContext context, int idx) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: GestureDetector(
                      onTap: () => _search(context, ref, searchHistory[idx]),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ref.watch(themeProvider)
                          ? Colors.grey.shade700 : Colors.grey.shade300,
                        ),
                        child: ListTile(
                          title: Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              searchHistory[idx],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_sharp, size: 20),
                            onPressed: () {
                              ref.read(searchHistoryProvider.notifier).removeSearch(idx);
                              searchHistory =
                                  ref.watch(searchHistoryProvider.notifier).history;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _search(BuildContext context, WidgetRef ref, String keyword) {
    ref.read(searchProvider.notifier).setKeyword(keyword);
    ref.read(searchHistoryProvider.notifier).addSearch(keyword);
    Navigator.pushNamed(context, '/search');
    ref.read(isMoviesProvider.notifier).changeState();
  }

}