import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/models/show.dart';
import 'package:movies_app/providers/category_provider.dart';
import 'package:movies_app/providers/home_provider.dart';
import 'package:movies_app/providers/show_provider.dart';
import 'package:movies_app/services/theme.dart';

class HomeWidget extends ConsumerWidget {

  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Show>> popularMovies = ref.watch(popularMoviesProvider);
    AsyncValue<List<Show>> popularSeries = ref.watch(popularSeriesProvider);
    AsyncValue<List<Show>> miniseries = ref.watch(miniseriesProvider);
      return RefreshIndicator(
        color: Colors.grey,
        onRefresh: () async {
          popularMovies = ref.refresh(popularMoviesProvider);
          popularSeries = ref.refresh(popularSeriesProvider);
          miniseries= ref.refresh(miniseriesProvider);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const SizedBox(height: 10),
              _buildGroup(context, ref, 'Popular Movies'),
              _buildGrid(context, ref, popularMovies),
              const SizedBox(height: 10),
              _buildGroup(context, ref, 'Popular Series'),
              _buildGrid(context, ref, popularSeries),
              const SizedBox(height: 10),
              _buildGroup(context, ref, 'Mini-Series'),
              _buildGrid(context, ref, miniseries),
              const SizedBox(height: 30),
              _buildCategories(ref),
            ],
    ),
        ),
      );
  }

  Widget _buildGroup(BuildContext context, WidgetRef ref, String group) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            group,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 15,
                color: theme.primaryColor,
              ),
            ),
            onPressed: () {
              ref.read(titleProvider.notifier).changeTitle(group);
              Navigator.pushNamed(context, '/shows');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, WidgetRef ref, AsyncValue<List<Show>> shows) =>
      shows.when(
          loading: () => SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          error: (ex, stack) => SizedBox(
            height: 200,
            child: Center(
              child: Text('Error: $ex'),
            ),
          ),
          data: (data) {
            data = getRandom(data);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: 200,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.6,
                  mainAxisSpacing: 5,
                ),
                itemCount: 15,
                itemBuilder: (BuildContext context, int idx) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            imageUrl: data[idx].poster,
                            fit: BoxFit.cover,
                            placeholder: (context, _) =>
                                Container(color: ref.watch(themeProvider)
                                ? Colors.grey.shade700
                                : Colors.grey.shade300),
                          ),
                        ),
                        onTap: () {
                          ref.read(selectedShowProvider.notifier).changeShow(
                              data[idx].id);
                          Navigator.pushNamed(context, '/show');
                        },
                      ),
                    ),
              ),
            );
          }
      );


  Widget _buildCategories(WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final categories = <String>[
      'Action',
      'Sci-fi',
      'Romance',
      'History',
      'Drama',
      'Comedy',
      'Adventure',
      'Crime',
      'War',
      'Animation',
      'Fantasy',
      'Horror',
      'Sport',
      'Biography',
      'Documentary',
      'Family',
    ];
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 16,
            itemBuilder: (context, idx) => GestureDetector(
              onTap: () {
                ref.read(titleProvider.notifier).changeTitle(categories[idx]);
                Navigator.pushNamed(context, '/shows');
              },
              child: Container(
                decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
                ),
                  child: Center(
                    child: Text(
                      categories[idx],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                   ),
                 ),
               ),
            ),
          ),
        ]
      ),
    );
  }

}