part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailEvent extends Equatable {
  const PokemonDetailEvent();

  @override
  List<Object> get props => [];
}

class NoPokemonEvent extends PokemonDetailEvent {
  @override
  List<Object> get props => [];
}

class LoadingPokemonEvent extends PokemonDetailEvent {
  const LoadingPokemonEvent(this.pokemonIndex);

  final int pokemonIndex;

  @override
  List<Object> get props => [pokemonIndex];
}

class SelectPokemonEvent extends PokemonDetailEvent {
  const SelectPokemonEvent(this.selectedPokemon);

  final PokemonDetailResponse selectedPokemon;

  @override
  List<Object> get props => [selectedPokemon];
}
