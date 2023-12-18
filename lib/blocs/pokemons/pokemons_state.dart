import 'package:equatable/equatable.dart';

import '../../models/pokemon.dart';

enum PokemonsStatus { initial, loading, success, failure }

class PokemonsState extends Equatable {
  final PokemonsStatus status;
  final bool isLightTheme;
  final List<Pokemon> pokemons;
  final Pokemon? deletedPokemon;
  final List<Pokemon> searchedPokemon;
  final Pokemon? selectedPokemon;

  const PokemonsState({
    this.status = PokemonsStatus.initial,
    this.isLightTheme = true,
    this.pokemons = const [],
    this.deletedPokemon,
    this.searchedPokemon = const [],
    this.selectedPokemon,
  });

  PokemonsState copyWith({
    PokemonsStatus? status,
    bool? isLightTheme,
    List<Pokemon>? pokemons,
    Pokemon? deletedPokemon,
    List<Pokemon>? searchedPokemon,
    Pokemon? selectedPokemon,
  }) {
    return PokemonsState(
      status: status ?? this.status,
      isLightTheme: isLightTheme ?? this.isLightTheme,
      pokemons: pokemons ?? this.pokemons,
      deletedPokemon: deletedPokemon ?? this.deletedPokemon,
      searchedPokemon: searchedPokemon ?? this.searchedPokemon,
      selectedPokemon: selectedPokemon ?? this.selectedPokemon,
    );
  }

  @override
  List<Object?> get props => [status,isLightTheme, pokemons, deletedPokemon, searchedPokemon];
}
