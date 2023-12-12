import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/poke_theme.dart';
import 'package:pokemon/repository/poke_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> pokemon = [];
  Pokemon? selectedPokemon;
  bool isLightTheme = true;

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  _loadPokemons() async {
    try {
      List<Pokemon> fetchedPokemons = await pokeRepository.fetchPokemons();

      setState(() {
        pokemon = fetchedPokemons;
      });
    } catch (e) {
      print('Erreur lors du chargement des Pokémon: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData selectedTheme = isLightTheme ? PokeTheme.themeLight : PokeTheme.themeDark;
    return MaterialApp(
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
          title: const Text(
            'Pokemons',
            style: TextStyle(fontSize: 22, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 28,
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 28,
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed('/addPokemons');
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
                              itemCount: pokemon.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                  key: Key(pokemon[index].id.toString()),
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
                                        selectedPokemon = pokemon[index];
                                      });
                                    },
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 28,
                                          child: pokemon[index].imageUrl.isNotEmpty ? Image.network(pokemon[index].imageUrl) : const FlutterLogo(size: 24),
                                        ),
                                        title: Text(pokemon[index].name),
                                        subtitle: Text('Types: ${pokemon[index].types.map((type) => type.name).join(', ')}'),
                                        trailing: const Icon(Icons.favorite_border),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: pokemon.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                  key: Key(pokemon[index].id.toString()),
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
                                        selectedPokemon = pokemon[index];
                                      });
                                    },
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: GridTile(
                                        child: Center(
                                          child: Container(
                                            width: 80,
                                            color: Colors.white,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 60,
                                                  child: pokemon[index].imageUrl.isNotEmpty
                                                      ? Image.network(
                                                          pokemon[index].imageUrl,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : const FlutterLogo(size: 24),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      pokemon[index].name,
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
                    )
                  : const Center(
                      child: Text('Sélectionnez un Pokémon'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
