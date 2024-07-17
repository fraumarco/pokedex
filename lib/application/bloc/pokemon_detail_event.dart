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
  @override
  List<Object> get props => [];
}

class SelectPokemonEvent extends PokemonDetailEvent {
  SelectPokemonEvent(this.selectedPokemonIndex);

  final int selectedPokemonIndex;

  @override
  List<Object> get props => [selectedPokemonIndex];
}
