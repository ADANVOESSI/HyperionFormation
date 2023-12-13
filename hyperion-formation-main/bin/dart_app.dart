// ignore_for_file: unused_local_variable

/// # READ !
///
/// * bash `dart create dart_app`
/// * @see: `pubspec.yaml`
/// * @see: `pub get`
///
/// ## [Dart cheatsheet codelab](https://dart.dev/codelabs/dart-cheatsheet)
///
/// ## [A tour of the Dart language](https://dart.dev/guides/language/language-tour)
///
void main(List<String> args) async {
  /// * commentaires

  /// * variables
  // const = initialized at compile-time
  // final  = single-assignment
  const String pikachu = 'pikachu';
  const pikachuCount = 1;
  const tortank = 'tortank';

  // * string interpolation ($)

  // * null safety (?, ??, ??=)
  // ...

  // * Conditional property access
  // myObject?.someProperty
  // myObject?.someMethod()

  // * Collection literals (List, Set, Map)
  // const listOfPokemons = <String>[];
  // listOfPokemons.addAll([pikachu, tortank]);

  // const setOfPokemons = {pikachu, tortank};

  // const mapOfPokemons = {
  //   'pikachu': pikachuCount,
  //   'tortank': 1,
  // };

  // * arrow syntaxe
  // listOfPokemons.firstWhere(
  //   (pokemon) {
  //     return pokemon == pikachu;
  //   },
  // );

  // * cascade notation (..)

  // * controle flow statement
  // if (cond)
  // while (year < 2016)
  // for (final object in flybyObjects)
  // for (int month = 1; month <= 12; month++)
}

// * class (abstract)
class Pokemon {
  final String name;

  // * private field
  // final int count;

  // * getter / setter

  // * constructor (this, super, named, factory)

  Pokemon(this.name);
  // Pokemon.empty(empty) : this('');
  // Pokemon.caninos() : name = 'caninos';
  // factory Pokemon.fromName(String name) => Pokemon(name);

  // const constructors : all final
  // initializer list: before constructor body

  // * optional positional parameter

  // * named parameter & required

  // * exception
  String searchPsykokwak() {
    try {
      throw PokemonNotFoundException();
    } on PokemonNotFoundException {
      // A specific exception
      // handlePokemonNotFoundException();
    } on Exception catch (e) {
      // Anything else that is an exception
      print('Unknown exception: $e');
      rethrow;
    } catch (e) {
      // No specified type, handles all
      print('Something really unknown: $e');
      rethrow;
    } finally {
      // Always executed
    }
    return 'Psykokwak';
  }

  // * enums

  // * extensions

  // * Asynchronous (async, await, Future)
}

class PokemonNotFoundException implements Exception {}

enum PokemonType { eau, feu, plante }

enum PokemonTypeExtended {
  eau(code: 'water'),
  feu(code: 'fire'),
  plante(code: 'plant');

  const PokemonTypeExtended({required this.code});

  final String code;

  bool get isPlant => this == PokemonTypeExtended.plante;
}
