import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/application/models/logged_user.dart';
import 'package:pokedex/application/views/authentication/authentication_view.dart';
import 'package:pokedex/application/views/splash/splash_view.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_view.dart';
import 'package:pokedex/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashView();
          }

          if (snapshot.connectionState == ConnectionState.done) {}

          if (snapshot.hasData) {
            setLoggedUserData(snapshot.data!);
            return PokemonListView();
          }

          return const AuthenticationView();
        },
      ),
    );
  }

  void setLoggedUserData(User user) async {
    LoggedUser.instance.email = user.email!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    LoggedUser.instance.name = userData.data()!["name"];
  }
}
