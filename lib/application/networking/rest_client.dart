import 'package:dio/dio.dart';
import 'package:pokedex/application/networking/response/pokemon_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';
part 'rest_client.g.dart';

class Apis {
  static const String pokemon = "pokemon?limit=20&offset={offset}";
}

@RestApi(baseUrl: "https://pokeapi.co/api/v2/")
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET(Apis.pokemon)
  Future<PokemonResponse> getPaginatedPokemon({
    @Path("offset") required int offset,
  });
}
