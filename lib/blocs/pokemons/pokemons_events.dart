import 'package:equatable/equatable.dart';

import '../../models/pokemon.dart';

sealed class PokemonsEvent extends Equatable {
  const PokemonsEvent();

  @override
  List<Object> get props => [];
}

final class PokemonsLoadingEvent extends PokemonsEvent {}

class LoadPokemons extends PokemonsEvent {}

class PokemonsDeleted extends PokemonsEvent {
  final int index;

  const PokemonsDeleted({required this.index});

  @override
  List<Object> get props => [index];
}

class PokemonSelected extends PokemonsEvent {
  final Pokemon selectedPokemon;

  const PokemonSelected(this.selectedPokemon);

  @override
  List<Object> get props => [selectedPokemon];
}


class DeleteAllPokemons extends PokemonsEvent {}

class ThemeChanged extends PokemonsEvent {
  final bool isLightTheme;

  const ThemeChanged(this.isLightTheme);

  @override
  List<Object> get props => [isLightTheme];
}

class SearchPokemon extends PokemonsEvent {
  final String searchText;

  const SearchPokemon(this.searchText);

  @override
  List<Object> get props => [searchText];
}

