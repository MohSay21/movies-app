import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/ui/views/home_view.dart';
import 'package:movies_app/ui/views/login_view.dart';

class MainView extends StatelessWidget {

  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return const HomeView();
            } else if (snapshot.hasError) {
              return const Center(child: Text(
                'Something went wrong...',
                style: TextStyle(fontSize: 20),
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else {
              return const LoginView();
            }
          }
        ),
      );

}