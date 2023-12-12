import 'package:pokemon/models/pokemon_type.dart';
import 'package:pokemon/utils/extension/iterable_extension.dart';
import '../models/pokemon.dart';
import 'api/poke_api.dart';

class PokeRepository {
  List<Pokemon>? _pokemons;
  List<PokemonType>? _pokemonType;

  Future<List<Pokemon>> fetchPokemons({int chunkSize = 200}) async {
    if (_pokemons != null) {
      return Future.value(_pokemons);
    }
    _pokemons = await pokeApi.fetchPokemons(chunkSize: chunkSize);
    return Future.value(_pokemons);
  }

  Future<List<PokemonType>>? fetchPokemonTypes() async {
    if (_pokemonType != null) {
      return Future.value(_pokemonType);
    }

    final pokemons = await fetchPokemons();

    _pokemonType = pokemons.expand((pokemon) => pokemon.types).distinctBy((e) => e.name).toList(growable: false)..sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
    return Future.value(_pokemonType);
  }

  Future<void> addPokemon(Pokemon pokemon) async {
    pokemon.id = (_pokemons?.length ?? 0) + 1;
    _pokemons
      ?..add(pokemon)
      ..sort((first, second) => first.name.toLowerCase().compareTo(second.name.toLowerCase()));
  }

  Future<void> updatePokemon(Pokemon pokemon) async {
    final index = _pokemons?.indexWhere((p) => p.id == pokemon.id);
    if (index != null && index >= 0) {
      _pokemons?[index] = pokemon;
    }
    _pokemons?.sort((first, second) => first.name.toLowerCase().compareTo(second.name.toLowerCase()));
  }

  Future<void> deletePokemon(int index) async {
    if (_pokemons != null && index >= 0 && index < _pokemons!.length) {
      _pokemons!.removeAt(index);
    }
  }
}

PokeRepository pokeRepository = PokeRepository();

// Future<List<PokemonType>>? fetchPokemonTypes() async {
//   final pokemons = await fetchPokemons();
//
//   final types = pokemons
//       .expand((pokemon) => pokemon.types)
//       .distinctBy((e) => e.name)
//       .toList(growable: false)
//     ..sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
//   return types;
// }
