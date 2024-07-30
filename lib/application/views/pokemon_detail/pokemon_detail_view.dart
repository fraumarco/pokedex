import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/application/views/pokemon_detail/pokemon_detail_viewmodel.dart';
import 'package:pokedex/application/views/pokemon_detail/widgets/loaded_pokemon_detail.dart';
import 'package:pokedex/application/views/pokemon_detail/widgets/loading_pokemon_detail.dart';
import 'package:pokedex/application/views/pokemon_detail/widgets/no_pokemon_detail.dart';

@RoutePage()
class PokemonDetailView extends StatefulWidget {
  const PokemonDetailView({super.key});

  @override
  State<PokemonDetailView> createState() => _PokemonDetailViewState();
}

class _PokemonDetailViewState extends State<PokemonDetailView> {
  final PokemonDetailViewModel viewModel = PokemonDetailViewModel();

  late PokemonDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PokemonDetailBloc>(context);
  }

  @override
  void dispose() {
    _bloc.add(NoPokemonEvent());
    super.dispose();
  }

  void _tapFavorite() {
    setState(() {
      viewModel.setFavorite();
    });
  }

  Widget _activeView = const NoPokemonDetailWidget();

  void setView(Widget view) {
    setState(() {
      _activeView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is LoadingPokemonDetail) {
          viewModel.loadDetail(_bloc, state.pokemonIndex);
          return const LoadingPokemonDetailWidget();
        }

        if (state is SelectedPokemonDetail) {
          return LoadedPokemonDetailWidget(
              viewModel: viewModel, tapFavorite: _tapFavorite);
        }

        return const NoPokemonDetailWidget();
      },
      bloc: _bloc,
    );
  }
}

/* BlocConsumer(
        builder: (context, state) {
          return _activeView;
        },
        listener: (context, state) {
          if (state is LoadingPokemonDetail) {
            viewModel.loadDetail(_bloc, state.pokemonIndex);
            setView(const LoadingPokemonDetailWidget());
          }

          if (state is SelectedPokemonDetail) {
            setView(LoadedPokemonDetailWidget(
                viewModel: viewModel, tapFavorite: _tapFavorite));
          }

          if (state is NoPokemonDetail) {
            setView(const NoPokemonDetailWidget());
          }
        },
        bloc: _bloc); */

/* BlocListener<PokemonDetailBloc, PokemonDetailState>(
      listener: (context, state) {
        if (state is LoadingPokemonDetail) {
          viewModel.loadDetail(_bloc, state.pokemonIndex);
          setView(const LoadingPokemonDetailWidget());
        }

        if (state is SelectedPokemonDetail) {
          setView(LoadedPokemonDetailWidget(
              viewModel: viewModel, tapFavorite: _tapFavorite));
        }

        if (state is NoPokemonDetail) {
          setView(const NoPokemonDetailWidget());
        }
      },
      bloc: _bloc,
      child: _activeView,
    ); */