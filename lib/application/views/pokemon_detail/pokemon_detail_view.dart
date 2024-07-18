import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/application/extensions/string_extension.dart';
import 'package:pokedex/application/views/pokemon_detail/pokemon_detail_viewmodel.dart';

@RoutePage()
class PokemonDetailView extends StatefulWidget {
  const PokemonDetailView({super.key});

  @override
  State<PokemonDetailView> createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  final PokemonDetailViewModel viewModel = PokemonDetailViewModel();

  late PokemonDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PokemonDetailBloc>(context);
  }

  @override
  void dispose() {
    _bloc.add(NoPokemonEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (ctx1, state) {
          return OrientationBuilder(
            builder: (ctx2, orientation) {
              if (state is LoadingPokemonDetail) {
                viewModel.loadDetail(_bloc, state.pokemonIndex);
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
                  body: LayoutBuilder(
                    builder: (context, constraints) {
                      return Hero(
                        tag: viewModel.pokemonName,
                        child: Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                  maxWidth: constraints.maxWidth),
                              child: IntrinsicHeight(
                                child: Column(
                                  children: [
                                    Image.network(viewModel.pokemonImageUrl),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Text(
                                      "Name: ${viewModel.pokemonName}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Card(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const Text(
                                              "Statistics",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            for (final stat
                                                in viewModel.pokemonStats)
                                              Text(
                                                "${stat.stat?.name?.capitalized ?? ""}: ${stat.baseStat}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
                  child: Text("Please select one Pokémon "),
                ),
              );
            },
          );
        });
  }
}
