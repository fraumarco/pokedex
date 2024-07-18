import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/application/extensions/string_extension.dart';
import 'package:pokedex/application/networking/response/pokemon_detail_response.dart';
import 'package:pokedex/application/networking/rest_client.dart';
import 'package:dio/dio.dart';

class PokemonDetailViewModel {
  final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

  PokemonDetailResponse? _pokemon;

  void loadDetail(PokemonDetailBloc bloc, int pokemonIndex) async {
    final pokemonDetail =
        await client.getPokemonDetail(index: pokemonIndex + 1);

    _pokemon = pokemonDetail;

    bloc.add(SelectPokemonEvent(pokemonDetail));
  }

  String get pokemonImageUrl {
    if (_pokemon != null && _pokemon!.name != null) {
      return "https://img.pokemondb.net/sprites/home/normal/${_pokemon!.name}.png";
    }
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png"; //Returns a default image
  }

  String get pokemonName {
    if (_pokemon != null && _pokemon!.name != null) {
      return _pokemon!.name!.capitalized;
    }

    return "Unknown";
  }

  List<Stats> get _pokemonStats {
    if (_pokemon == null) {
      return [];
    }
    return _pokemon!.stats ?? [];
  }

  List<String> get pokemonStatsInfo {
    List<String> info = [];
    for (final stat in _pokemonStats) {
      info.add("${stat.stat?.name?.capitalized}: ${stat.baseStat}");
    }
    return info;
  }

  List<Types> get _pokemonTypes {
    if (_pokemon == null) {
      return [];
    }

    return _pokemon!.types ?? [];
  }

  List<String> get pokemonTypesInfo {
    List<String> info = [];
    for (final type in _pokemonTypes) {
      info.add("${type.type?.name?.capitalized}");
    }
    return info;
  }
}
