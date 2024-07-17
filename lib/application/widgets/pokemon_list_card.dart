import 'package:flutter/material.dart';
import 'package:pokedex/application/extensions/string_extension.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';

class PokemonListCard extends StatelessWidget {
  const PokemonListCard(
      {super.key, required this.pokemon, required this.pokemonIndex});

  final PokemonResultResponse pokemon;
  final int pokemonIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Row(
        children: [
          Image(
              image: NetworkImage(
                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonIndex.png")),
          const SizedBox(
            width: 16,
          ),
          Text(
            pokemon.name?.capitalized ?? "",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
          )
        ],
      ),
    );
  }
}
