import 'dart:io';

displayPokemonList(Set<String> pokemons) {
  print(''.padRight(20, '-'));
  print('${pokemons.length} pokemon(s) known');
  final pokemonList = pokemons.toList()..sort((a, b) => a.compareTo(b));
  for (final pokemon in pokemonList) {
    print(pokemon);
  }
  print(''.padLeft(20, '-'));
}

void main(List<String> args) async {
  print('\n/// DEBUT ///\n');
  print('Menu\n\t[pokemon name]: add a pokemon\n\tl: List pokemons\n\tq: Quit');

  final pokemons = <String>{};
  String? input;
  do {
    input = stdin.readLineSync();
    if (input == null || input.isEmpty) {
      print('// invalid entry');
    } else if (input == 'l') {
      displayPokemonList(pokemons);
    } else if (input == 'q') {
      print('// quitting...');
    } else {
      pokemons.add(input);
      print('// $input added');
    }
  } while (input != 'q');
  print('\n/// FIN ///\n');
}
