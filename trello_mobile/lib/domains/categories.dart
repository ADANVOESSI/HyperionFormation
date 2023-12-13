List<Categories> categorieFromJson(List<dynamic> listStrg) =>
    listStrg.map((val) => Categories.fromJson(val)).toList();

class Categories {
  final String name;
  final String description;

  Categories({required this.name, required this.description});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      name: json['nom'] as String,
      description: json['descriptions'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nom': name,
      'descriptions': description,
    };
  }
}
