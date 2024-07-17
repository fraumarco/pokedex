import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
        emit(LoadingPokemonDetail());
      },
    );
    on<SelectPokemonEvent>(
      (event, emit) async {
        emit(SelectedPokemonDetail(event.selectedPokemonIndex));
      },
    );
  }
}
