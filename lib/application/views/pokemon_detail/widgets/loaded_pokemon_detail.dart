import 'package:flutter/material.dart';
import 'package:pokedex/application/views/pokemon_detail/pokemon_detail_viewmodel.dart';
import 'package:pokedex/application/widgets/pokemon_detail_info_card.dart';

class LoadedPokemonDetailWidget extends StatelessWidget {
  const LoadedPokemonDetailWidget(
      {super.key, required this.viewModel, required this.tapFavorite});

  final PokemonDetailViewModel viewModel;
  final void Function() tapFavorite;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
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
                        onPressed: tapFavorite,
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
                                  onPressed: tapFavorite,
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
                                    fontSize: 28, fontWeight: FontWeight.bold),
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
      },
    );
  }
}
