import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/models/logged_user.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';
import 'package:pokedex/application/networking/rest_client.dart';
import 'package:dio/dio.dart';

class PokemonListViewModel extends Cubit<List<PokemonResultResponse>> {
  PokemonListViewModel() : super([]);

  String get loggedUserName {
    return LoggedUser.instance.name;
  }

  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  final List<PokemonResultResponse> _pokemonList = [];

  int _apiOffset = 0;

  void getData() async {
    final pokemon = await client.getPaginatedPokemon(offset: _apiOffset);

    _pokemonList.addAll(pokemon.results ?? []);

    print("NUMBER: ${_pokemonList.length}");

    emit([..._pokemonList]);

    _apiOffset += 20;
  }
}
