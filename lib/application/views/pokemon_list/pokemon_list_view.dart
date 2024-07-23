import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/models/pokemon.dart';
import 'package:pokedex/application/views/pokemon_detail/pokemon_detail_view.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_viewmodel.dart';
import 'package:pokedex/application/widgets/pokemon_list.dart';

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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListViewModel, List<Pokemon>>(
      bloc: viewModel,
      builder: (ctx, pokemonList) {
        return OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return Center(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.extentAfter == 0) {
                      viewModel.getData();
                    }
                    return false;
                  },
                  child: PokemonList(
                      pokemonList: pokemonList,
                      viewModel: viewModel,
                      orientation: orientation),
                ),
              );
            }

            return Row(
              children: [
                Expanded(
                  child: Center(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification &&
                            notification.metrics.extentAfter == 0) {
                          viewModel.getData();
                        }
                        return false;
                      },
                      child: Column(
                        children: [
                          if (kIsWeb)
                            const Text(
                              "All Pokémon",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          Expanded(
                            child: PokemonList(
                                pokemonList: pokemonList,
                                viewModel: viewModel,
                                orientation: orientation),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  child: PokemonDetailView(),
                )
              ],
            );
          },
        );
      },
    );
  }
}
