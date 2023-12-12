import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/models/pokemon_type.dart';
import 'package:pokemon/poke_routes.dart';
import 'package:pokemon/poke_theme.dart';
import 'package:pokemon/repository/poke_repository.dart';

class EditPokemons extends StatefulWidget {
  const EditPokemons({
    Key? key,
    required this.initialPokemon,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon? initialPokemon;
  final Pokemon pokemon;

  @override
  State<EditPokemons> createState() => _EditPokemonsState();
}

class _EditPokemonsState extends State<EditPokemons> {
  late Pokemon? selectedPokemon;
  List<Pokemon> pokemon = [];
  final List<PokemonType> _selectedTypes = [];
  late TextEditingController _nameController;
  late TextEditingController _imageUrlController;
  bool isLightTheme = true;
  String _name = '';
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    selectedPokemon = widget.initialPokemon;
    _nameController = TextEditingController(text: selectedPokemon?.name ?? '');
    _imageUrlController = TextEditingController(text: selectedPokemon?.imageUrl ?? '');
  }

  void _submitForm() {
    _name = _nameController.text.trim();
    _imageUrl = _imageUrlController.text.trim();

    if (_name.isNotEmpty && _imageUrl.isNotEmpty && _selectedTypes.isNotEmpty) {
      final updatedPokemon = Pokemon(
        id: selectedPokemon?.id ?? 0,
        name: _name,
        imageUrl: _imageUrl,
        types: _selectedTypes.toList(),
      );

      pokeRepository.updatePokemon(updatedPokemon).then((_) {
        pokeRoutes.go('/');
        // Afficher un message de confirmation ou rediriger vers une autre page
        // Vous pouvez également ajouter setState ici pour mettre à jour l'interface utilisateur si nécessaire
      }).catchError((error) {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = isLightTheme ? PokeTheme.themeLight : PokeTheme.themeDark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: selectedTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            iconSize: 28,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Update Pokemons',
            style: TextStyle(fontSize: 22, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
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
        body: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: selectedPokemon?.imageUrl != null && selectedPokemon!.imageUrl.isNotEmpty ? Image.network(selectedPokemon!.imageUrl) : const FlutterLogo(size: 100),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(width: 10),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nom Pokémon'),
                        onChanged: (value) {
                          setState(() {
                            selectedPokemon?.name = value;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: _submitForm,
                            child: const Text(
                              'Valider',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Annuler',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
