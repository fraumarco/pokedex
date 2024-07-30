import 'package:flutter/material.dart';

class LoadingPokemonDetailWidget extends StatelessWidget {
  const LoadingPokemonDetailWidget({super.key});

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
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
