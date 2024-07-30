import 'package:flutter/material.dart';

class NoPokemonDetailWidget extends StatelessWidget {
  const NoPokemonDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
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
  }
}
