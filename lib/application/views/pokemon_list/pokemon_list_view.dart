import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/navigation/app_router.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_viewmodel.dart';
import 'package:pokedex/application/widgets/loader_list_card.dart';
import 'package:pokedex/application/widgets/pokemon_list_card.dart';

@RoutePage()
class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

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
        title: Image.asset(
          'lib/assets/images/logo.png',
          width: 120,
        ),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.router.push(const AuthenticationRoute());
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
