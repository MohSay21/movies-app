import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/providers/category_provider.dart';
import 'package:movies_app/providers/home_provider.dart';
import 'package:movies_app/models/show.dart';
import 'package:movies_app/services/theme.dart';
import 'package:movies_app/ui/widgets/build_grid_widget.dart';

class ShowsView extends ConsumerWidget {

  const ShowsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider.notifier).title;
    final shows = _getShows(ref, title);
    final theme = Theme.of(context);
    final isDark = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.grey.shade300,
        foregroundColor: theme.colorScheme.secondary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,),
          onPressed: () {
            ref.read(titleProvider.notifier).changeTitle('');
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: shows.when(
        data: (data) => Container(
          padding: const EdgeInsets.all(8),
          child: buildGrid(ref, data),
        ),
        loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.grey)
        ),
        error: (ex, stack) => Center(child: Text('Error: $ex'),),
      ),
    );
  }

   AsyncValue<List<Show>> _getShows(WidgetRef ref, String title) {
    switch (title) {
      case 'Popular Movies': return ref.watch(popularMoviesProvider);
      case 'Popular Series': return ref.watch(popularSeriesProvider);
      case 'Mini-Series': return ref.watch(miniseriesProvider);
      default: return ref.watch(categoryProvider(
          ref.watch(titleProvider.notifier).title)
      );
    }
  }

}