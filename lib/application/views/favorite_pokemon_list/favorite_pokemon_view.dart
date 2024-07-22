import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/models/pokemon.dart';
import 'package:pokedex/application/views/favorite_pokemon_list/favorite_pokemon_viewmodel.dart';
import 'package:pokedex/application/views/pokemon_detail/pokemon_detail_view.dart';
import 'package:pokedex/application/widgets/pokemon_list.dart';

@RoutePage()
class FavoritePokemonView extends StatefulWidget {
  const FavoritePokemonView({super.key});

  @override
  State<FavoritePokemonView> createState() => _FavoritePokemonViewState();
}

class _FavoritePokemonViewState extends State<FavoritePokemonView> {
  final viewModel = FavoritePokemonViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favorites-${FirebaseAuth.instance.currentUser!.uid}')
            .orderBy("id")
            .snapshots(),
        builder: (ctx, snapshot) {
          return OrientationBuilder(
            builder: (context, orientation) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "No favorite Pokémons found.\nAdd some!",
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text("Ooops, something went wrong."),
                );
              }

              final pokemonList =
                  viewModel.getFavoritesFromDocs(snapshot.data!.docs);

              if (orientation == Orientation.portrait) {
                return PokemonList(
                    pokemonList: pokemonList,
                    viewModel: viewModel,
                    orientation: orientation,
                    withPagination: false);
              }

              return Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        if (kIsWeb)
                          const Text(
                            "Favorite Pokémon",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        Expanded(
                          child: PokemonList(
                              pokemonList: pokemonList,
                              viewModel: viewModel,
                              orientation: orientation,
                              withPagination: false),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: PokemonDetailView(),
                  )
                ],
              );
            },
          );
        });
  }
}
