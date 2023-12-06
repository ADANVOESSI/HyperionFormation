import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/repository/poke_repository.dart';

class AddPokemons extends StatefulWidget {
  const AddPokemons({super.key});

  @override
  State<AddPokemons> createState() => _AddPokemonsState();
}

enum PokemonType {
  Poison,
  Plante,
  Feu,
  Vol,
  Eau,
  Insecte,
  Normal,
  Electrik,
  Sol,
  Fee,
  poison,
  fighting,
}

extension PokemonTypeExtension on PokemonType {
  String get name {
    switch (this) {
      case PokemonType.Poison:
        return 'Poison';
      case PokemonType.Plante:
        return 'Plante';
      case PokemonType.Feu:
        return 'Feu';
      case PokemonType.Vol:
        return 'Vol';
      case PokemonType.Eau:
        return 'Eau';
      case PokemonType.Insecte:
        return 'Insecte';
      case PokemonType.Normal:
        return 'Normal';
      case PokemonType.Electrik:
        return 'Electrik';
      case PokemonType.Sol:
        return 'Sol';
      case PokemonType.Fee:
        return 'Fee';
      case PokemonType.poison:
        return 'poison';
      case PokemonType.fighting:
        return 'fighting';
    }
  }

  String get imageUrl {
    switch (this) {
      case PokemonType.Poison:
        return 'URL_IMAGE_POISON';
      case PokemonType.Plante:
        return 'URL_IMAGE_PLANTE';
      case PokemonType.Feu:
        return 'URL_IMAGE_FEU';
      case PokemonType.Vol:
        return 'URL_IMAGE_VOL';
      case PokemonType.Eau:
        return 'URL_IMAGE_EAU';
      case PokemonType.Insecte:
        return 'URL_IMAGE_INSECTE';
      case PokemonType.Normal:
        return 'URL_IMAGE_NORMAL';
      case PokemonType.Electrik:
        return 'URL_IMAGE_ELECTRIK';
      case PokemonType.Sol:
        return 'URL_IMAGE_SOL';
      case PokemonType.Fee:
        return 'URL_IMAGE_FEE';
      case PokemonType.poison:
        return 'URL_IMAGE_poison';
      case PokemonType.fighting:
        return 'URL_IMAGE_fighting';
    }
  }
}

class _AddPokemonsState extends State<AddPokemons> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pokeRepository = PokeRepository();
  List<PokemonType> filters = [];
  List<PokemonType> _selectedTypes = [];
  String _name = '';
  String _imageUrl = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Nom: $_name');
      print('Image URL: $_imageUrl');
      print('Types sélectionnés: $_selectedTypes');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  void _loadPokemons() async {
    List<Pokemon> pokemons = await pokeRepository.fetchPokemons();
    List<String> allTypes = [];

    pokemons.forEach((pokemon) {
      pokemon.types.forEach((type) {
        if (!allTypes.contains(type.name)) {
          allTypes.add(type.name);
        }
      });
    });

    List<PokemonType> pokemonTypes = allTypes.map((typeName) {
      switch (typeName) {
        case 'Poison':
          return PokemonType.Poison;
        case 'Plante':
          return PokemonType.Plante;
        case 'Feu':
          return PokemonType.Feu;
        case 'Vol':
          return PokemonType.Vol;
        case 'Eau':
          return PokemonType.Eau;
        case 'Insecte':
          return PokemonType.Insecte;
        case 'Normal':
          return PokemonType.Normal;
        case 'Electrik':
          return PokemonType.Electrik;
        case 'Sol':
          return PokemonType.Sol;
        case 'Fee':
          return PokemonType.Fee;
        case 'poison':
          return PokemonType.poison;
        case 'fighting':
          return PokemonType.fighting;
        default:
          return PokemonType.Normal;
      }
    }).toList();
    setState(() {
      _selectedTypes = pokemonTypes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  iconSize: 28,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  'Pokemons',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: PhysicalShape(
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                    elevation: 0,
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(200.0, 50.0, 200.0, 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pokemon",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(labelText: 'Nom'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez entrer un nom';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _name = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  decoration: const InputDecoration(labelText: 'URL de l\'image'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez entrer une URL d\'image valide';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _imageUrl = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),
                                Wrap(
                                  spacing: 5.0,
                                  children: PokemonType.values.map((PokemonType pokemonType) {
                                    return FilterChip(
                                      label:
                                      // Row(
                                      //   children: [
                                          // Image.network(
                                          //   pokemonType.imageUrl,
                                          //   width: 24,
                                          //   height: 24,
                                          // ),
                                          // const SizedBox(width: 4),
                                          Text(
                                            pokemonType.name,
                                          // ),

                                      ),
                                      selected: _selectedTypes.contains(pokemonType),
                                      onSelected: (bool selected) {
                                        setState(() {
                                          if (selected) {
                                            _selectedTypes.add(pokemonType);
                                          } else {
                                            _selectedTypes.remove(pokemonType);
                                          }
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text('Valider'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ));
  }
}
