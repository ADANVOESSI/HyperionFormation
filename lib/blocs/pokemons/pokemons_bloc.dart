import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pokemon/blocs/pokemons/pokemons_events.dart';
import 'package:pokemon/blocs/pokemons/pokemons_state.dart';

import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/repository/poke_repository.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  bool _isLightTheme = true;

  // final PokeRepository _pokeRepository;

  PokemonsBloc() : super(const PokemonsState()) {
    on<ThemeChanged>(_themeChanged);
    on<SearchPokemon>(_searchPokemon);
    on<PokemonsDeleted>(_deletedPokemon);
    on<LoadPokemons>(_loadPokemons);
    on<DeleteAllPokemons>(_deleteAllPokemons);
    on<PokemonSelected>(_pokemonSelected);
  }

  Future<void> _loadPokemons(LoadPokemons event, Emitter<PokemonsState> emit) async {
    try {
      final fetchedPokemons = await pokeRepository.fetchPokemons();
      emit(
        state.copyWith(
          status: PokemonsStatus.success,
          pokemons: fetchedPokemons,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PokemonsStatus.failure));
    }
  }

  void _themeChanged(ThemeChanged event, Emitter<PokemonsState> emit) {
    _isLightTheme = event.isLightTheme;
    emit(state.copyWith(isLightTheme: _isLightTheme));
  }

  // Future<void> _pokemonSelected(
  //     PokemonSelected event, Emitter<PokemonsState> emit) async {
  //   emit(state.copyWith(selectedPokemon: event.selectedPokemon));
  // }

  void _pokemonSelected(PokemonSelected event, Emitter<PokemonsState> emit) {
    emit(state.copyWith(selectedPokemon: event.selectedPokemon));
    print('La sélection dans le bloc : ${event.selectedPokemon}');
  }

  void _searchPokemon(SearchPokemon event, Emitter<PokemonsState> emit) {
    final searchText = event.searchText.toLowerCase();

    final searchedPokemon = state.pokemons.where((poke) => poke.name.toLowerCase().contains(searchText)).toList();

    emit(
      state.copyWith(
        searchedPokemon: searchedPokemon,
      ),
    );
  }

  Future<void> _deletedPokemon(PokemonsDeleted event, Emitter<PokemonsState> emit) async {
    try {
      final index = event.index;
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pokemons').where('id', isEqualTo: index).get();
      final documents = querySnapshot.docs;

      if (documents.isNotEmpty) {
        final pokemonData = documents.first.data();

        if (pokemonData is Map<String, dynamic>) {
          final deletedPokemon = _convertToPokemon(pokemonData);
          await documents.first.reference.delete();
          emit(state.copyWith(deletedPokemon: deletedPokemon));
        } else {
          print('Les données récupérées ne sont pas de type Map<String, dynamic>.');
        }
      } else {
        print("Aucun Pokemon avec l'ID $index trouvé.");
      }
    } catch (e) {
      print("Aucun Pokemon avec l'ID trouvé.");
    }
  }

  Future<void> _deleteAllPokemons(DeleteAllPokemons event, Emitter<PokemonsState> emit) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('pokemons').get();
      final documents = querySnapshot.docs;

      await Future.forEach(documents, (doc) async {
        await doc.reference.delete();
      });

      emit(
        state.copyWith(
          status: PokemonsStatus.success,
          pokemons: [],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PokemonsStatus.failure));
    }
  }

  Pokemon _convertToPokemon(Map<String, dynamic> data) {
    return Pokemon.fromJson(data);
  }
}
