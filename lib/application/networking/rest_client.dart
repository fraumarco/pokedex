import 'package:dio/dio.dart';
import 'package:pokedex/application/networking/response/pokemon_detail_response.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';
part 'rest_client.g.dart';

class BaseValues {
  static const String path = "https://pokeapi.co/api/v2/";
}

class Apis {
  static const String pokemon = "pokemon";
  static const String pokemonDetail = "pokemon/{index}/";
}

@RestApi(baseUrl: BaseValues.path)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET(Apis.pokemon)
  Future<PokemonResponse> getInitialPokemon();

  @GET("{path}")
  Future<PokemonResponse> getPaginatedPokemon({
    @Path("path") required String path,
  });

  @GET(Apis.pokemonDetail)
  Future<PokemonDetailResponse> getPokemonDetail({
    @Path("index") required int index,
  });
}
