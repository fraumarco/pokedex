import 'package:flutter/material.dart';

class WebDrawer extends StatelessWidget {
  const WebDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.red),
            child: Row(
              children: [
                Text("Gotta Catch 'Em All",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
              size: 26,
            ),
            title: const Text('All', style: TextStyle(fontSize: 20)),
            onTap: () {
              onSelectScreen('all');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.star,
              size: 26,
            ),
            title: const Text('Favorites', style: TextStyle(fontSize: 20)),
            onTap: () {
              onSelectScreen('favorites');
            },
          ),
        ],
      ),
    );
  }
}
