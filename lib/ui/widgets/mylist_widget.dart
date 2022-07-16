import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/providers/show_provider.dart';
import 'package:movies_app/providers/mylist_provider.dart';
import 'package:movies_app/services/theme.dart';

class MylistWidget extends ConsumerWidget {

  const MylistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final shows = ref.watch(mylistProvider.notifier).mylist;
    return Container(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1 / 1.6,
          ),
          itemCount: shows.length,
          itemBuilder: (context, idx) => GestureDetector(
            onTap: () {
              ref.read(selectedShowProvider.notifier).changeShow(shows[idx].id);
              Navigator.pushNamed(context, '/show');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: shows[idx].poster,
                placeholder: (context, _) => Container(color: isDark
                ? Colors.grey.shade700 : Colors.grey.shade300),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
    );
  }

}