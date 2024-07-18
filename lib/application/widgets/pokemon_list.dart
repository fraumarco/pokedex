import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/application/navigation/app_router.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';
import 'package:pokedex/application/views/pokemon_list/pokemon_list_viewmodel.dart';
import 'package:pokedex/application/widgets/loader_list_card.dart';
import 'package:pokedex/application/widgets/pokemon_list_card.dart';

class PokemonList extends StatefulWidget {
  const PokemonList(
      {super.key,
      required this.pokemonList,
      required this.viewModel,
      required this.orientation});

  final List<PokemonResultResponse> pokemonList;
  final PokemonListViewModel viewModel;
  final Orientation orientation;

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late PokemonDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            widget.viewModel.getData();
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          itemCount: widget.pokemonList.length + 1,
          itemBuilder: (builderCtx, index) {
            if (index < widget.pokemonList.length) {
              return PokemonListCard(
                pokemon: widget.pokemonList[index],
                pokemonIndex: index,
                onTap: () {
                  _bloc.add(LoadingPokemonEvent(index));
                  if (widget.orientation == Orientation.portrait) {
                    context.router.push(const PokemonDetailRoute());
                  }
                },
              );
            } else {
              return const LoaderListCard();
            }
          },
        ),
      ),
    );
  }
}
