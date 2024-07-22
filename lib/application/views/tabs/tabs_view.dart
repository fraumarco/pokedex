import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/application/navigation/app_router.dart';
import 'package:pokedex/application/views/favorite_pokemon_list/favorite_pokemon_view.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_view.dart';
import 'package:pokedex/application/widgets/web_drawer.dart';

@RoutePage()
class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() {
    return _TabsViewState();
  }
}

class _TabsViewState extends State<TabsView> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    _selectPage(identifier == "all" ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = _selectedPageIndex == 0
        ? const PokemonListView()
        : const FavoritePokemonView();

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/images/logo.png',
          width: 120,
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.router.replace(const AuthenticationRoute());
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
      drawer: kIsWeb ? WebDrawer(onSelectScreen: _setScreen) : null,
      body: activePage,
      bottomNavigationBar: kIsWeb
          ? null
          : BottomNavigationBar(
              unselectedItemColor: Colors.white.withOpacity(0.5),
              selectedItemColor: Colors.white,
              backgroundColor: Colors.red,
              onTap: _selectPage,
              currentIndex: _selectedPageIndex,
              items: const [
                BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(
                      Icons.list,
                    ),
                    label: "All pokemons"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star), label: "Favorites")
              ],
            ),
    );
  }
}
