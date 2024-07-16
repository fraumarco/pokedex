import 'package:flutter/material.dart';

class LoaderListCard extends StatelessWidget {
  const LoaderListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Row(
        children: [Spacer(), CircularProgressIndicator(), Spacer()],
      ),
    );
  }
}
