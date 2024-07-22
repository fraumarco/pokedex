import 'package:flutter/material.dart';
import 'package:pokedex/application/extensions/string_extension.dart';
import 'package:pokedex/application/models/pokemon.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';

class PokemonListCard extends StatelessWidget {
  const PokemonListCard(
      {super.key, required this.pokemon, required this.onTap});

  final Pokemon pokemon;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: SizedBox(
                width: 100,
                height: 100,
                child: FadeInImage(
                  image: NetworkImage(
                      "https://img.pokemondb.net/sprites/home/normal/${pokemon.name}.png"),
                  placeholder:
                      const AssetImage("lib/assets/images/placeholder.png"),
                  width: 100,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              pokemon.name.capitalized,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            )
          ],
        ),
      ),
    );
  }
}
