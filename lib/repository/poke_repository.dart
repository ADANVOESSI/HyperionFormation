import 'package:pokemon/models/pokemon_type.dart';
import 'package:pokemon/utils/extension/iterable_extension.dart';
import '../models/pokemon.dart';
import 'api/poke_api.dart';

class PokeRepository {
  List<Pokemon>? _pokemons;

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
        .distinctBy((e) => e.name)
        .toList(growable: false)
      ..sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
    return types;
  }

  Future<void> deletePokemon(int index) async {
    if (_pokemons != null && index >= 0 && index < _pokemons!.length) {
      _pokemons!.removeAt(index);
    }
  }

}

PokeRepository pokeRepository = PokeRepository();
