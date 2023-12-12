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

  Future<void> deletePokemon(int index) async {
    if (_pokemons != null && index >= 0 && index < _pokemons!.length) {
      _pokemons!.removeAt(index);
    }
  }

  Future<void> addPokemon(String name, String imageUrl, List<PokemonType> selectedTypes) async {
    Pokemon newPokemon = Pokemon(
      name: name,
      imageUrl: imageUrl,
      types: selectedTypes,
      id: _pokemons!.length + 1,
    );

    _pokemons!.add(newPokemon);
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
