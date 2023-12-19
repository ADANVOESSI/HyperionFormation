import 'package:pokemon/models/pokemon_type.dart';

class Pokemon {
  int id;
  String name;
  String imageUrl;
  final List<PokemonType> types;

  Pokemon({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.types,
  });

  bool isValid() => name.isNotEmpty && imageUrl.isNotEmpty && types.isNotEmpty;

  factory Pokemon.fromJson(Map<String, dynamic> json,
      {String dataSource = 'api'}) {
    final jsonTypesKey = (dataSource == 'api') ? 'apiTypes' : 'types';
    final jsonTypesArray = json[jsonTypesKey] as List? ?? [];
    final types =
        jsonTypesArray.map((type) => PokemonType.fromJson(type)).toList();
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
      types: types,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
      'types': types.map((type) => type.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return '${name.padRight(15)} | [${types.map((t) => t.name).join(',')}]';
  }
}
