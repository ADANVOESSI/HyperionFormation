List<Taches>tachesFromJson(List<dynamic> listStrg) =>
    listStrg.map((val) => Taches.fromJson(val)).toList();

class Taches {
  final String? name;
  final String? description;
  final String? createdAt;
  final String? endAt;
  final String? membres;
  final String? categories;
  final int? status;
  Taches(
      {this.name,
      this.description,
      this.categories,
      this.createdAt,
      this.endAt,
      this.membres,
      this.status});

  factory Taches.fromJson(Map<String, dynamic> json) {
    return Taches(
        name: json['task_name'],
        description: json['descriptions'],
        categories: json['categories'],
        createdAt: json['createdAt'],
        endAt: json['endAt'],
        membres: json['membres'],
        status: int.parse(json['status']));
  }
    Map<String, dynamic> toJson() {
    return {'task_name': name, 'descriptions': description, 'categories': categories, 'createdAt': createdAt, 'endAt': endAt, 'membres': membres, 'status': status};
  }
}