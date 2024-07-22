import 'package:flutter/material.dart';

class LoaderListCard extends StatelessWidget {
  const LoaderListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16), //FIXME: ci sono molti valori HD, forse meglio fare un file di variabili?
      child: const Row(
        children: [Spacer(), CircularProgressIndicator(), Spacer()],
      ),
    );
  }
}
