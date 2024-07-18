import 'package:flutter/material.dart';
import 'package:pokedex/application/extensions/string_extension.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';

class PokemonListCard extends StatelessWidget {
  const PokemonListCard(
      {super.key,
      required this.pokemon,
      required this.pokemonIndex,
      required this.onTap});

  final PokemonResultResponse pokemon;
  final int pokemonIndex;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: pokemon.name?.capitalized ?? "",
        child: Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Image.network(
                  "https://img.pokemondb.net/sprites/home/normal/${pokemon.name}.png",
                  width: 100,
                ),
              ),
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
        ),
      ),
    );
  }
}
