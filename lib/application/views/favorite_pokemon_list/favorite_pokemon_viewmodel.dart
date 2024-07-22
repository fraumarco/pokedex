import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/models/pokemon.dart';
import 'package:pokedex/application/protocols/pokemon_list_viewmodel_protocol.dart';

class FavoritePokemonViewModel extends Cubit<List<Pokemon>>
    with PokemonListViewModelProtocol {
  FavoritePokemonViewModel() : super([]);

  @override
  void getData() async {
    List<Pokemon> favoritePokemons = [];
    final userCredentials = FirebaseAuth.instance.currentUser;
    final favorites = await FirebaseFirestore.instance
        .collection("favorites-${userCredentials!.uid}")
        .get();

    for (final favorite in favorites.docs) {
      favoritePokemons
          .add(Pokemon(favorite.data()["id"], favorite.data()["name"]));
    }

    emit([...favoritePokemons]);
  }

  List<Pokemon> getFavoritesFromDocs(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    List<Pokemon> favoritePokemons = [];

    for (final favorite in docs) {
      favoritePokemons
          .add(Pokemon(favorite.data()["id"], favorite.data()["name"]));
    }

    return favoritePokemons;
  }
}
