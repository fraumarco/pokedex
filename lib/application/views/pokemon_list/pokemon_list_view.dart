import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/application/models/logged_user.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ciao ${LoggedUser.instance.name}!"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: const Center(
        child: Text("Pokemon list"),
      ),
    );
  }
}
