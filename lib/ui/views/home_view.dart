import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/services/authentication.dart';
import 'package:movies_app/services/theme.dart';
import 'package:movies_app/ui/widgets/home_widget.dart';
import 'package:movies_app/ui/widgets/search_widget.dart';
import 'package:movies_app/ui/widgets/mylist_widget.dart';

class HomeView extends StatefulWidget {

  const HomeView({Key? key}) : super(key: key);

  @override
  State createState() => _HomeView();

}

class _HomeView extends State<HomeView> {

  int _currentIdx = 1;
  final widgets = [
    SearchWidget(),
    const HomeWidget(),
    const MylistWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movies App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: _myBNB(),
      body: widgets[_currentIdx],
    );
  }

  _myBNB() => BottomNavigationBar(
    selectedItemColor: Theme.of(context).colorScheme.secondary,
    unselectedItemColor: Theme.of(context).colorScheme.secondary,
    elevation: 0,
    currentIndex: _currentIdx,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined,),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'My list',
      ),
    ],
    onTap: (idx) => setState(() => _currentIdx = idx),
    showUnselectedLabels: false,
  );

}

class MyDrawer extends ConsumerWidget {

  MyDrawer({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      width: 300,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 60),
          _buildUserInfo(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Divider(),
          ),
          _buildOptions(context, ref),
        ],
      ),
    );
  }

    Widget _buildUserInfo() =>
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: _auth.currentUser!.photoURL == null
                    ? CircleAvatar(
                  child: Text(
                    'U',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : Image.network(
                  _auth.currentUser!.photoURL!,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _auth.currentUser!.displayName ?? 'name',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                _auth.currentUser!.email ?? 'email',
                style: const TextStyle(),
              ),
            ],
          ),
        );

    Widget _buildOptions(BuildContext context, WidgetRef ref) {
      final isDark = ref.watch(themeProvider);
      final theme = Theme.of(context);
      return Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: isDark
                    ? Colors.grey.shade700 : Colors.grey.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                fixedSize: const Size(200, 50),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                      'Settings'
                  ),
                  Icon(Icons.settings),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: isDark
                ? Colors.grey.shade700 : Colors.grey.shade300,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                fixedSize: const Size(200, 50),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                      'Rate us'
                  ),
                  Icon(Icons.star),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                await signout(context);
                Navigator.popAndPushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                primary: theme.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                fixedSize: const Size(200, 50),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                      'Sign-out'
                  ),
                  Icon(Icons.arrow_back),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'V- 1.0.0',
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: Icon(isDark ? Icons.dark_mode : Icons.light),
                      onPressed: () =>
                          ref.read(themeProvider.notifier).changeTheme(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

  }