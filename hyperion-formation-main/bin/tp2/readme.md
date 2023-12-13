
# TP

* appeler une API json
* instancier une liste d'objets
* ordonner une liste par ordre alpha
* afficher le resultat

## Classes

### ./models/

#### pokemon_types.dart

* name  
* imageUrl

#### pokemon.dart

* id
* name
* imageUrl
* List pokemon_types

### ./repository/poke_repository.dart

```dart
  Future<List<Pokemon>> fetchPokemons({int chunkSize = 50}) async {
    final response = await http.get(
        Uri.parse('https://pokebuildapi.fr/api/v1/pokemon/limit/$chunkSize'));
    // TODO... 
  }
```

## output

```bash
fetching pokemons...

-----------------------------------
POKEMON         | TYPE
-----------------------------------
Aspicot         | [Poison,Insecte]
Bulbizarre      | [Poison,Plante]
Carabaffe       | [Eau]
Carapuce        | [Eau]
Chenipan        | [Insecte]
Chrysacier      | [Insecte]
Coconfort       | [Poison,Insecte]
Dardargnan      | [Poison,Insecte]
Dracaufeu       | [Vol,Feu]
Florizarre      | [Poison,Plante]
Herbizarre      | [Poison,Plante]
Papilusion      | [Vol,Insecte]
Rattata         | [Normal]
Rattatac        | [Normal]
Reptincel       | [Feu]
Roucarnage      | [Normal,Vol]
Roucool         | [Normal,Vol]
Roucoups        | [Normal,Vol]
Salamèche       | [Feu]
Tortank         | [Eau]
-----------------------------------

...fetched 20 pokemons
```
