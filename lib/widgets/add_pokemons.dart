import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/poke_theme.dart';
import 'package:pokemon/repository/poke_repository.dart';
import '../models/pokemon_type.dart';
import '../screens/pokemons_edit/edit_pokemons.dart';

// class AddPokemons extends StatefulWidget {
//   const AddPokemons({
//     Key? key,
//     required this.initialPokemon,
//     required this.pokemon,
//   }) : super(key: key);
//
//   final Pokemon? initialPokemon;
//   final Pokemon pokemon;
//
//   @override
//   State<AddPokemons> createState() => _AddPokemonsState();
// }
//
// class _AddPokemonsState extends State<AddPokemons> {
//   List<PokemonType>? _allPokemonTypes;
//   late Pokemon _pokemon;
//   late TextEditingController _nameController;
//   late TextEditingController _imageController;
//   bool isLightTheme = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _pokemon = widget.pokemon;
//
//     _nameController = TextEditingController(text: _pokemon.name)..addListener(() => _pokemon.name = _nameController.text);
//     _imageController = TextEditingController(text: _pokemon.imageUrl)..addListener(() => _pokemon.imageUrl = _imageController.text);
//
//     pokeRepository.fetchPokemonTypes().then((value) => setState(() => _allPokemonTypes = value));
//   }
//
//   _onTypeChanged(PokemonType type, bool selected) {
//     if (selected) {
//       _pokemon.types.add(type);
//     } else {
//       _pokemon.types.remove(type);
//     }
//     setState(() {});
//   }
//
//   void _submitForm(BuildContext context) {
//     final String _name = _nameController.text.trim();
//     final String _imageUrl = _imageController.text.trim();
//
//     if (_name.isNotEmpty && _imageUrl.isNotEmpty && _pokemon.types.isNotEmpty) {
//       final updatedPokemon = Pokemon(
//         id: _pokemon.id,
//         name: _name,
//         imageUrl: _imageUrl,
//         types: _pokemon.types.toList(),
//       );
//
//       // pokeRepository.updatePokemon(updatedPokemon).then((_) {
//       //   Navigator.of(context).pushReplacement(
//       //     MaterialPageRoute(
//       //       builder: (context) => const MyHomePage(),
//       //     ),
//       //   );
//       // }).catchError((error) {});
//     } else {
//       // Gérer le cas où les champs sont vides
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeData selectedTheme = isLightTheme ? PokeTheme.themeLight : PokeTheme.themeDark;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: selectedTheme,
//       home: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             leading: IconButton(
//               iconSize: 28,
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             title: const Text(
//               'Update Pokemons',
//               style: TextStyle(fontSize: 22, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
//             ),
//             actions: <Widget>[
//               Switch(
//                 value: isLightTheme,
//                 onChanged: (value) {
//                   setState(() {
//                     isLightTheme = value;
//                   });
//                 },
//                 activeTrackColor: Colors.black26,
//                 activeColor: Colors.white,
//               ),
//             ],
//           ),
//           body: Row(
//             children: [
//               Flexible(
//                 flex: 2,
//                 child: Center(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(100.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           TextField(
//                             decoration: const InputDecoration(label: Text('Nom')),
//                             controller: _nameController,
//                           ),
//                           TextField(
//                             decoration: const InputDecoration(label: Text('Image')),
//                             controller: _imageController,
//                           ),
//                           if (_allPokemonTypes != null) ...[
//                             const SizedBox(height: 20),
//                             const Text('Types'),
//                             Wrap(
//                               spacing: 5,
//                               children: _allPokemonTypes!
//                                   .map(
//                                     (type) => PokemonTypeChip(
//                                   type,
//                                   initialValue: _pokemon.types.contains(type),
//                                   onChanged: (value) => _onTypeChanged(type, value),
//                                 ),
//                               )
//                                   .toList(),
//                             ),
//                           ],
//                           const SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               FilledButton.icon(
//                                 icon: const Icon(Icons.cancel),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                                 label: const Text('Annuler'),
//                               ),
//                               FilledButton.icon(
//                                 icon: const Icon(Icons.save),
//                                 onPressed: () {
//                                   _submitForm(context);
//                                 },
//                                 label: const Text('Valider'),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class AddPokemons extends StatefulWidget {
  const AddPokemons({super.key});

  @override
  State<AddPokemons> createState() => _AddPokemonsState();
}

class _AddPokemonsState extends State<AddPokemons> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final pokeRepository = PokeRepository();
  List<Pokemon> pokemon = [];
  bool isLightTheme = true;

  final List<PokemonType> _selectedTypes = [];
  String _name = '';
  String _imageUrl = '';

  void _submitForm() {
    if (_name.isNotEmpty && _imageUrl.isNotEmpty && _selectedTypes.isNotEmpty) {
      pokeRepository.addPokemon(pokemon as Pokemon);
      setState(() {
        _name = '';
        _imageUrl = '';
        _selectedTypes.clear();
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = isLightTheme ? PokeTheme.themeLight : PokeTheme.themeDark;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: selectedTheme,
        home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  iconSize: 28,
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  'Add Pokemons',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: <Widget>[
                  Switch(
                    value: isLightTheme,
                    onChanged: (value) {
                      setState(() {
                        isLightTheme = value;
                      });
                    },
                    activeTrackColor: Colors.black26,
                    activeColor: Colors.white,
                  ),
                ],
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
                                  decoration: const InputDecoration(labelText: 'Nom'),
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
                                FutureBuilder(
                                  future: pokeRepository.fetchPokemonTypes(),
                                  builder: (context, AsyncSnapshot<List<PokemonType>> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Erreur: ${snapshot.error}');
                                    } else if (!snapshot.hasData) {
                                      return const Text('Pas de données');
                                    } else {
                                      return Wrap(
                                        spacing: 5.0,
                                        children: snapshot.data!.map((pokemonType) {
                                          return FilterChip(
                                            label: SizedBox(
                                              width: 80,
                                              child: Row(
                                                children: [
                                                  Image.network(
                                                    pokemonType.imageUrl,
                                                    width: 20,
                                                    height: 20,
                                                  ),
                                                  Text(pokemonType.name),
                                                ],
                                              ),
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
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text(
                                    'Valider',
                                    style: TextStyle(fontSize: 18),
                                  ),
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
