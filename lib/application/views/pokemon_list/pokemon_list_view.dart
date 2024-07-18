import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/navigation/app_router.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';
import 'package:pokedex/application/views/pokemon_detail/pokemon_detail_view.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_viewmodel.dart';
import 'package:pokedex/application/widgets/pokemon_list.dart';

@RoutePage()
class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final viewModel = PokemonListViewModel();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/images/logo.png',
          width: 120,
        ),
        backgroundColor: Colors.red,
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
      body: BlocBuilder<PokemonListViewModel, List<PokemonResultResponse>>(
        bloc: viewModel,
        builder: (ctx, pokemonList) {
          return OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return PokemonList(
                    pokemonList: pokemonList,
                    viewModel: viewModel,
                    orientation: orientation);
              }

              return Row(
                children: [
                  Expanded(
                    child: PokemonList(
                        pokemonList: pokemonList,
                        viewModel: viewModel,
                        orientation: orientation),
                  ),
                  const Expanded(
                    child: PokemonDetailView(),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
