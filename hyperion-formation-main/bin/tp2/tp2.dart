import 'repository/poke_repository.dart';

void main(List<String> args) async {
  print('\n/// DEBUT ///\n');
  print('fetching pokemons...\n');
  final pokes = await pokeRepository.fetchPokemons(chunkSize: 20);

  final sorted = pokes..sort((a, b) => a.name.compareTo(b.name));
  print("-----------------------------------");
  print("${'POKEMON'.padRight(15)} | TYPE");
  print("-----------------------------------");
  for (final poke in sorted) {
    print(poke);
  }
  print("-----------------------------------");

  print('\n...fetched ${pokes.length} pokemons');
  print('\n/// FIN ///\n');
}
