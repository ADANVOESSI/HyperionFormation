List<Membres> membreFromJson(List<dynamic> listStrg) =>
    listStrg.map((val) => Membres.fromJson(val)).toList();

class Membres {
  final String name;
  final String prenom;
  final String phone;
  final String email;
  final String role;
  final String password;

  Membres(
      {required this.name,
      required this.prenom,
      required this.phone,
      required this.email,
      required this.role,
      required this.password,
      });
  factory Membres.fromJson(Map<String, dynamic> json) {
    return Membres(
        name: json['nom'],
        prenom: json['prenoms'],
        phone: json['telephone'],
        email: json['email'],
        role: json['roles'],
        password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'nom': name, 'prenoms': prenom, 'telephone': phone, 'email': email, 'roles': role, 'password': password};
  }
}
