class PokemonType {
  final String name;
  final String imageUrl; 

  PokemonType({required this.name, required this.imageUrl});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['name'],
      imageUrl: json['image'],
    );
  }
}
