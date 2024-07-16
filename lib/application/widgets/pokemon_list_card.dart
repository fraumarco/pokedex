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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
