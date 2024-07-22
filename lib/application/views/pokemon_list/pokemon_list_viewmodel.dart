import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/models/pokemon.dart';
import 'package:pokedex/application/networking/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:pokedex/application/protocols/pokemon_list_viewmodel_protocol.dart';

class PokemonListViewModel extends Cubit<List<Pokemon>>
    with PokemonListViewModelProtocol {
  PokemonListViewModel() : super([]);

  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  final List<Pokemon> _pokemon = [];
  String? nextPage;

  @override
  void getData() async {
    final pokemon = (nextPage != null)
        ? await client.getPaginatedPokemon(path: nextPage!)
        : await client.getInitialPokemon();
    final pokemonResultList = pokemon.results ?? [];

    nextPage = pokemon.next?.replaceAll(BaseValues.path, "");

    _pokemon.addAll(pokemonResultList.map((item) =>
        Pokemon(pokemonResultList.indexOf(item) + 1, item.name ?? "")));

    emit([..._pokemon]);
  }
}
