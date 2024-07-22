import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/application/views/pokemon_detail/pokemon_detail_viewmodel.dart';
import 'package:pokedex/application/widgets/pokemon_detail_info_card.dart';

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

  void _tapFavorite() {
    setState(() {
      viewModel.setFavorite();
    });
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
                          title: Text(
                            viewModel.pokemonName,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            IconButton(
                                onPressed: _tapFavorite,
                                icon: Icon(viewModel.isFavorite
                                    ? Icons.star
                                    : Icons.star_border))
                          ],
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
                                    if (orientation == Orientation.landscape)
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: _tapFavorite,
                                          icon: Icon(viewModel.isFavorite
                                              ? Icons.star
                                              : Icons.star_border),
                                        ),
                                      ),
                                    Image.network(viewModel.pokemonImageUrl),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    if (orientation == Orientation.landscape)
                                      Text(
                                        "Name: ${viewModel.pokemonName}",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    PokemonDetailInfoCard(
                                        title: "Statistics",
                                        infoValues: viewModel.pokemonStatsInfo),
                                    PokemonDetailInfoCard(
                                        title: "Types",
                                        infoValues: viewModel.pokemonTypesInfo),
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
