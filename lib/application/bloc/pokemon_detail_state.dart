part of 'pokemon_detail_bloc.dart';

sealed class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {}

class LoadingPokemonDetail extends PokemonDetailInitial {
  @override
  List<Object> get props => [];
}

class NoPokemonDetail extends PokemonDetailInitial {
  @override
  List<Object> get props => [];
}

class SelectedPokemonDetail extends PokemonDetailInitial {
  SelectedPokemonDetail(this.selectedPokemonIndex);

  final int selectedPokemonIndex;

  @override
  List<Object> get props => [selectedPokemonIndex];
}
