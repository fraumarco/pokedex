import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';

@RoutePage()
class PokemonDetailView extends StatefulWidget {
  const PokemonDetailView({super.key});

  @override
  State<PokemonDetailView> createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  late PokemonDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PokemonDetailBloc>(context);
    _bloc.add(LoadingPokemonEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (ctx1, state) {
          return OrientationBuilder(
            builder: (ctx2, orientation) {
              if (state is LoadingPokemonDetail) {
                return Scaffold(
                  appBar: orientation == Orientation.portrait
                      ? AppBar(
                          backgroundColor: Colors.red,
                          title: Image.asset(
                            'lib/assets/images/logo.png',
                            width: 120,
                          ),
                        )
                      : null,
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is SelectedPokemonDetail) {
                return Scaffold(
                  appBar: orientation == Orientation.portrait
                      ? AppBar(
                          backgroundColor: Colors.red,
                          title: Image.asset(
                            'lib/assets/images/logo.png',
                            width: 120,
                          ),
                        )
                      : null,
                  body: Center(
                    child: Text("Pokemon: ${state.selectedPokemonIndex}"),
                  ),
                );
              }
              return Scaffold(
                appBar: orientation == Orientation.portrait
                    ? AppBar(
                        backgroundColor: Colors.red,
                        title: Image.asset(
                          'lib/assets/images/logo.png',
                          width: 120,
                        ),
                      )
                    : null,
                body: const Center(
                  child: Text("No pokemon"),
                ),
              );
            },
          );
        });
  }
}
