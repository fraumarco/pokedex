part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {}

class NoPokemonDetail extends PokemonDetailInitial {
  @override
  List<Object> get props => [];
}

class LoadingPokemonDetail extends PokemonDetailInitial {
  LoadingPokemonDetail(this.pokemonIndex);

  final int pokemonIndex;

  @override
  List<Object> get props => [pokemonIndex];
}

class SelectedPokemonDetail extends PokemonDetailInitial {
  SelectedPokemonDetail(this.selectedPokemon);

  final PokemonDetailResponse selectedPokemon;

  @override
  List<Object> get props => [selectedPokemon];
}
