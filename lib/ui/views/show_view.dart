import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/providers/mylist_provider.dart';
import 'package:movies_app/providers/show_provider.dart';
import 'package:movies_app/models/details.dart';

class ShowView extends ConsumerWidget {

  const ShowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(selectedShowProvider.notifier).id;
    final details = ref.watch(showProvider(id));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: details.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.grey)),
        error: (ex, stack) => Center(child: Text('Error: $ex')),
        data: (data) => ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  _buildStack(context, ref, size, data),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Text(
                      data.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildGenres(context, size, data),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildElement('Type:', data),
                        _buildElement('Rating:', data),
                        _buildElement(
                            data.type == 'Movie' ? 'Run-time:' : 'Episodes',
                            data,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    height: 150,
                    child: Text(
                      data.plot,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: const Text(
                      'Stars',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildStars(data),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: const Text(
                      'Similar Shows',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSimilars(ref, size, data),
                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }

}

Widget _buildStack(BuildContext context, WidgetRef ref, Size size, Details data) =>
    SizedBox(
      height: size.height * 0.6,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: data.poster,
              fit: BoxFit.cover,
              placeholder: (context, _) =>
                  Container(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: size.width / 5,
            left: size.width / 5,
            child: CachedNetworkImage(
              imageUrl: data.poster,
              width: size.width / 3,
              fit: BoxFit.cover,
              placeholder: (context, _) =>
                  Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: 10,
            left: 15,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                ref.read(selectedShowProvider.notifier).changeShow('');
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            bottom: 10,
            height: 50,
            width: size.width / 2,
            left: size.width / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () =>
                      ref.read(mylistProvider.notifier).addShow(data),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget _buildGenres(BuildContext context, Size size, Details data) => Container(
  padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(
        data.genres[0],
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      Text(
        data.genres[1],
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      Text(
        data.genres[2],
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  ),
);

Widget _buildStars(Details data) => SizedBox(
  height: 140,
  child: ListView.separated(
    separatorBuilder: (BuildContext context, int idx) =>
    const SizedBox(width: 10),
    scrollDirection: Axis.horizontal,
    itemCount: 5,
    itemBuilder: (BuildContext context, int idx) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: CachedNetworkImage(
              width: 70,
              height: 70,
              imageUrl: data.stars[idx].image,
              fit: BoxFit.cover,
              placeholder: (context, _) => Container(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 7.5),
          Text(
            data.stars[idx].name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data.stars[idx].character,
            style: const TextStyle(
            ),
          ),
        ],
      ),
    ),
  ),
);

Widget _buildSimilars(WidgetRef ref, Size size, Details data) => Container(
  height: 200,
  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
  child: GridView.builder(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      mainAxisSpacing: 8,
      childAspectRatio: 1.6,
    ),
    itemCount: 10,
    itemBuilder: (BuildContext context, int idx) =>
        GestureDetector(
          onTap: () {
            ref.read(selectedShowProvider.notifier).changeShow(
                data.similars[idx].id
            );
            Navigator.pushNamed(context, '/show');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: data.similars[idx].poster,
              fit: BoxFit.cover,
              placeholder: (context, _) => Container(
                color: Colors.grey,
              ),
            ),
          ),
        ),
  ),
);

Widget _buildElement(String title, Details details) {
  String text = '';
  switch (title) {
    case 'Type:':
      text = details.type;
      break;
    case 'Rating:':
      text = details.rating;
      break;
    case 'Run-time:':
      text = '${details.length} min';
      break;
    case 'Episodes:':
      text = details.length;
      break;
  }
  return Column(
    children: <Widget>[
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(height: 5),
      Text(
        text,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
    ],
  );
}