import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/application/networking/response/pokemon_detail_response.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc() : super(PokemonDetailInitial()) {
    on<NoPokemonEvent>(
      (event, emit) {
        emit(NoPokemonDetail());
      },
    );
    on<LoadingPokemonEvent>(
      (event, emit) {
        emit(LoadingPokemonDetail(event.pokemonIndex));
      },
    );
    on<SelectPokemonEvent>(
      (event, emit) async {
        emit(SelectedPokemonDetail(event.selectedPokemon));
      },
    );
  }
}
