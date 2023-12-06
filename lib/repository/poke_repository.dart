import 'package:pokemon/models/pokemon_type.dart';

import '../models/pokemon.dart';

import 'api/poke_api.dart';

class PokeRepository {
  List<Pokemon>? _pokemons;

  /// Fetches a list of [Pokemon] from the [PokeApi].
  Future<List<Pokemon>> fetchPokemons({int chunkSize = 50}) async {
    if (_pokemons != null) {
      return Future.value(_pokemons);
    }
    _pokemons = await pokeApi.fetchPokemons(chunkSize: chunkSize);
    return Future.value(_pokemons);
  }

  Future<List<PokemonType>> fetchPokemonTypes() async {
    final pokemons = await fetchPokemons();
    final types = pokemons
        .expand((pokemon) => pokemon.types)
        .toList(growable: false)
      ..sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
    return types;
  }
}

PokeRepository pokeRepository = PokeRepository();
