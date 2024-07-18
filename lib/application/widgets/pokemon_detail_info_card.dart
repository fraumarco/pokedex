import 'package:flutter/material.dart';

class PokemonDetailInfoCard extends StatelessWidget {
  const PokemonDetailInfoCard(
      {super.key, required this.title, required this.infoValues});

  final String title;
  final List<String> infoValues;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(
              height: 16,
            ),
            for (final info in infoValues)
              Text(
                info,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
