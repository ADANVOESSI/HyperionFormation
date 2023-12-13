import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/poke_routes.dart';
import 'package:pokemon/poke_theme.dart';
import 'package:pokemon/repository/poke_repository.dart';
import 'package:pokemon/widgets/edit_pokemons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> pokemon = [];
  List<Pokemon> allPokemon = [];
  List<Pokemon> searchedPokemon = [];
  Pokemon? selectedPokemon;
  bool isLightTheme = true;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    allPokemon = List.from(pokemon);
    _loadPokemons();
  }

  void _editPokemon(BuildContext context, Pokemon? selectedPokemon) {
    if (selectedPokemon != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPokemons(
            initialPokemon: selectedPokemon,
            pokemon: selectedPokemon,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun Pokémon sélectionné'),
        ),
      );
    }
  }

  _loadPokemons() async {
    try {
      List<Pokemon> fetchedPokemons = await pokeRepository.fetchPokemons();

      setState(() {
        pokemon = fetchedPokemons;
        allPokemon = List.from(pokemon);
      });
    } catch (e) {
      print('Erreur lors du chargement des Pokémon: $e');
    }
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
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Rechercher un Pokemon...',
                    hintStyle: TextStyle(),
                  ),
                  style: const TextStyle(),
                  onChanged: (value) {
                    setState(() {
                      searchedPokemon = allPokemon.where((poke) => poke.name.toLowerCase().contains(value.toLowerCase())).toList();
                    });
                  },
                )
              : const Text(
                  'Pokemons',
                  style: TextStyle(fontSize: 22, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                ),
          actions: <Widget>[
            _isSearching
                ? IconButton(
                    icon: const Icon(Icons.close),
                    iconSize: 28,
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                      });
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search),
                    iconSize: 28,
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
            IconButton(
              iconSize: 28,
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
            ),
            IconButton(
                iconSize: 28,
                icon: const Icon(Icons.download),
                onPressed: () {
                  _loadPokemons();
                }),
            IconButton(
              iconSize: 28,
              icon: const Icon(Icons.add),
              onPressed: () {
                pokeRoutes.go('/addPokemons');
              },
            ),
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
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  body: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(
                            child: SizedBox(
                              width: 35,
                              height: 30,
                              child: Icon(Icons.list, size: 30),
                            ),
                          ),
                          Tab(
                            child: SizedBox(
                              width: 35,
                              height: 25,
                              child: Icon(Icons.dashboard, size: 30),
                            ),
                          ),
                        ],
                        labelColor: Colors.red,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: _isSearching ? searchedPokemon.length : pokemon.length,
                              itemBuilder: (BuildContext context, int index) {
                                final currentPokemon = _isSearching ? searchedPokemon[index] : pokemon[index];
                                return Visibility(
                                  visible: _isSearching && currentPokemon.name.toLowerCase() != _searchController.text.toLowerCase(),
                                  replacement: Dismissible(
                                    key: Key(currentPokemon.id.toString()),
                                    direction: DismissDirection.startToEnd,
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: (DismissDirection direction) async {
                                      await pokeRepository.deletePokemon(index);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Pokemon supprimé'),
                                          action: SnackBarAction(
                                            label: 'Annuler',
                                            onPressed: () {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPokemon = currentPokemon;
                                        });
                                      },
                                      child: Card(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 28,
                                            child: currentPokemon.imageUrl.isNotEmpty ? Image.network(currentPokemon.imageUrl) : const FlutterLogo(size: 24),
                                          ),
                                          title: Text(currentPokemon.name),
                                          subtitle: Text('Types: ${currentPokemon.types.map((type) => type.name).join(', ')}'),
                                          trailing: const Icon(Icons.favorite_border),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(),
                                );
                              },
                            ),
                            GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: _isSearching ? searchedPokemon.length : pokemon.length,
                              itemBuilder: (BuildContext context, int index) {
                                final currentPokemon = _isSearching ? searchedPokemon[index] : pokemon[index];
                                return Visibility(
                                  visible: _isSearching && currentPokemon.name.toLowerCase() != _searchController.text.toLowerCase(),
                                  replacement: Dismissible(
                                    key: Key(currentPokemon.id.toString()),
                                    direction: DismissDirection.startToEnd,
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.red,
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onDismissed: (DismissDirection direction) async {
                                      await pokeRepository.deletePokemon(index);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Pokemon supprimé'),
                                          action: SnackBarAction(
                                            label: 'Annuler',
                                            onPressed: () {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedPokemon = currentPokemon;
                                        });
                                      },
                                      child: Card(
                                        color: Colors.transparent,
                                        elevation: 0,
                                        child: GridTile(
                                          child: Center(
                                            child: Container(
                                              width: 80,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    child: currentPokemon.imageUrl.isNotEmpty
                                                        ? Image.network(
                                                            currentPokemon.imageUrl,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : const FlutterLogo(size: 24),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        currentPokemon.name,
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Container(),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(width: 10),
            Expanded(
              flex: 2,
              child: selectedPokemon != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedPokemon!.name,
                                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                  selectedPokemon!.imageUrl.isNotEmpty ? Image.network(selectedPokemon!.imageUrl) : const FlutterLogo(size: 100),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8.0,
                              children: selectedPokemon!.types.map((type) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      type.imageUrl,
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(width: 2),
                                    Text(
                                      type.name,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('Sélectionnez un Pokémon'),
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _editPokemon(context, selectedPokemon),
          label: const Text('Edit'),
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation de suppression"),
          content: const Text("Êtes-vous sûr de vouloir supprimer tous les Pokémons ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                await pokeRepository.deleteAllPokemons();
                setState(() {
                  pokemon.clear();
                  selectedPokemon = null;
                });
                Navigator.of(context).pop(true);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
