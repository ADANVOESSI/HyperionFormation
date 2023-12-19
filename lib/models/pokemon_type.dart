class PokemonType {
  final int? id;
  final String name;
  final String imageUrl;

  PokemonType({this.id, required this.name, required this.imageUrl});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
    };
  }
}
