import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/providers/search_provider.dart';
import 'package:movies_app/ui/widgets/build_grid_widget.dart';
import 'package:movies_app/services/theme.dart';

class SearchView extends ConsumerStatefulWidget {

  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SearchViewState();

}

class _SearchViewState extends ConsumerState<SearchView> {

  @override
  Widget build(BuildContext context) {
    final keyword = ref.watch(searchProvider);
    final movies = ref.watch(searchMoviesProvider(keyword));
    final series = ref.watch(searchSeriesProvider(keyword));
    final isMovies = ref.watch(isMoviesProvider);
    final ctrl = PageController();
    final pageView = PageView(
      controller: ctrl,
      onPageChanged: (idx) =>
          ref.read(isMoviesProvider.notifier).changeState(),
      children: <Widget>[
        movies.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.grey),
          ),
          error: (ex, _) => Text('Error: $ex'),
          data: (data) => buildGrid(ref, data),
        ),
        series.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.grey),
          ),
          error: (ex, _) => Text('Error: $ex'),
          data: (data) => buildGrid(ref, data),
        ),
      ],
    );

    return Scaffold(
     appBar: AppBar(
       title: Text(
         'Search for "$keyword"',
         style: const TextStyle(
           fontSize: 20,
           fontWeight: FontWeight.bold,
         ),
       ),
       centerTitle: true,
       leading: IconButton(
         icon: const Icon(Icons.arrow_back),
         onPressed: () => Navigator.pop(context),
       ),
       backgroundColor: ref.watch(themeProvider)
       ? Colors.black : Colors.grey.shade300,
       elevation: 0,
     ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      'Movies',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: isMovies ? FontWeight.bold : FontWeight.normal,
                        color: isMovies
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                        ctrl.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Series',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: isMovies ? FontWeight.normal : FontWeight.bold,
                        color: isMovies
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    onPressed: () {
                        ctrl.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: pageView,
            ),
          ],
        ),
      ),
    );
  }

}