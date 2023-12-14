import 'package:pokemon/models/pokemon_type.dart';
import 'package:pokemon/utils/extension/iterable_extension.dart';
import '../models/pokemon.dart';
import 'api/poke_api.dart';

class PokeRepository {
  List<Pokemon>? _pokemons;
  List<PokemonType>? _pokemonType;

  PokeRepository._();

  Future<List<Pokemon>> fetchPokemons() async {
    _pokemons = await pokeApi.fetchPokemonsOnFirebase();
    if (_pokemons != null) {
      _pokemons!.sort((a, b) => a.name.compareTo(b.name));
      return _pokemons!;
    }
    return [];
  }

  Future<List<PokemonType>> fetchPokemonTypes() async {
    final pokemons = await fetchPokemons();

    print("Mes types de pokemons sont : $pokemons");
    final List<PokemonType> allTypes = pokemons.expand((pokemon) => pokemon.types).toList().distinctBy((type) => type.name).toList(growable: false)
      ..sort((a, b) => a.name.toUpperCase().compareTo(b.name.toUpperCase()));
    return allTypes;
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

  Future<void> deleteAllPokemons() async {
    _pokemons?.clear();
  }
}

PokeRepository pokeRepository = PokeRepository._();

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
