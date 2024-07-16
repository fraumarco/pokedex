import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_viewmodel.dart';
import 'package:pokedex/application/widgets/loader_list_card.dart';
import 'package:pokedex/application/widgets/pokemon_list_card.dart';

class PokemonListView extends StatefulWidget {
  PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final viewModel = PokemonListViewModel();

  @override
  void initState() {
    super.initState();

    viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pokedex!",
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
      body: BlocBuilder<PokemonListViewModel, List<PokemonResultResponse>>(
        bloc: viewModel,
        builder: (ctx, pokemonList) {
          return Center(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.extentAfter == 0) {
                  viewModel.getData();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: pokemonList.length + 1,
                itemBuilder: (builderCtx, index) {
                  if (index < pokemonList.length) {
                    return PokemonListCard(
                        pokemon: pokemonList[index], pokemonIndex: index + 1);
                  } else {
                    return const LoaderListCard();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
