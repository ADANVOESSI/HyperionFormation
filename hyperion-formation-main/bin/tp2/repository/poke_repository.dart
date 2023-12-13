import '../models/pokemon.dart';

import 'api/poke_api.dart';

class PokeRepository {
  const PokeRepository();

  /// Fetches a list of [Pokemon] from the [PokeApi].
  Future<List<Pokemon>> fetchPokemons({int chunkSize = 50}) {
      // repository should return local data if available and not expired
      return pokeApi.fetchPokemons(chunkSize: chunkSize);
  }
}

const pokeRepository = PokeRepository();
