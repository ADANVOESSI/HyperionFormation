import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/repository/poke_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon> pokemon = [];
  Pokemon? selectedPokemon;

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
                Icons.home,
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
            actions: <Widget>[
              IconButton(
                iconSize: 28,
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 28,
                icon: const Icon(
                  Icons.filter_list_rounded,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 28,
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/addPokemons');
                },
              ),
            ],
          ),
          body: Row(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
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
                            child: pokemon[index].imageUrl.isNotEmpty ? Image.network(pokemon[index].imageUrl) : FlutterLogo(size: 24),
                          ),
                          title: Text(pokemon[index].name),
                          subtitle: Text('Types: ${pokemon[index].types.map((type) => type.name).join(', ')}'),
                          trailing: const Icon(Icons.heart_broken),
                        ),
                      ),
                    );
                  },
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
      ),
    );
  }

}
