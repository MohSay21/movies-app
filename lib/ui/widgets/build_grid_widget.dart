import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/models/show.dart';
import 'package:movies_app/providers/show_provider.dart';

Widget buildGrid(WidgetRef ref, List<Show> shows) => GridView.builder(
    physics: const BouncingScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 0.75,
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
          placeholder: (context, _) => Container(color: Colors.grey),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );