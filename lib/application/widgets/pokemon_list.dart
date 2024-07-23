import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/application/extensions/string_extension.dart';
import 'package:pokedex/application/models/pokemon.dart';
import 'package:pokedex/application/navigation/app_router.dart';
import 'package:pokedex/application/protocols/pokemon_list_viewmodel_protocol.dart';
import 'package:pokedex/application/widgets/loader_list_card.dart';
import 'package:pokedex/application/widgets/pokemon_list_card.dart';

//FIXME: Per me questi sono componenti delle singole pagine, cosi mi aspetterei che fossero comuni per tutti... ma sembrano specifici alla lista, dettaglio. Quindi per il package avrei creato un "component" e li avrei messi li dentro
class PokemonList extends StatefulWidget {
  const PokemonList(
      {super.key,
      required this.pokemonList,
      required this.viewModel,
      required this.orientation,
      this.withPagination = true});

  final List<Pokemon> pokemonList;
  final PokemonListViewModelProtocol viewModel;
  final Orientation orientation;
  final bool withPagination;

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
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: widget.pokemonList.length + (widget.withPagination ? 1 : 0),
      itemBuilder: (builderCtx, index) {
        if (index < widget.pokemonList.length) {
          return Hero(
            tag: widget.pokemonList[index].name.capitalized,
            child: PokemonListCard(
              pokemon: widget.pokemonList[index],
              onTap: () {
                _bloc.add(LoadingPokemonEvent(widget.pokemonList[index].id));
                if (widget.orientation == Orientation.portrait) {
                  context.router.push(const PokemonDetailRoute());
                }
              },
            ),
          );
        } else {
          return const LoaderListCard();
        }
      },
    );
  }
}
