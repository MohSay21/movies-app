import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies_app/ui/views/home_view.dart';
import 'package:movies_app/ui/views/main_view.dart';
import 'package:movies_app/ui/views/show_view.dart';
import 'package:movies_app/ui/views/login_view.dart';
import 'package:movies_app/ui/views/shows_view.dart';
import 'package:movies_app/ui/views/search_view.dart';
import 'package:movies_app/ui/views/signup_view.dart';
import 'package:movies_app/ui/views/reset_password_view.dart';
import 'package:movies_app/services/authentication.dart';
import 'package:movies_app/services/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Movies app',
      routes: {
        '/': (context) => const MainView(),
        '/main': (context) => const MainView(),
        '/show': (context) => const ShowView(),
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignupView(),
        '/shows': (context) => const ShowsView(),
        '/search': (context) => const SearchView(),
        '/home': (context) => const HomeView(),
        '/reset_password': (context) => const ResetPasswordView(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(themeProvider) ? ThemeMode.dark : ThemeMode.light,
      darkTheme: MyTheme.dark,
      theme: MyTheme.light,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
    );
  }

}