// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// // Définition de la classe représentant un objet
// class MonObjet {
//   final String nom;
//
//   MonObjet({required this.nom});
//
//   factory MonObjet.fromJson(Map<String, dynamic> json) {
//     return MonObjet(
//       nom: json['nom'] ?? '', // Assurez-vous d'adapter cette ligne selon la structure de votre API JSON
//     );
//   }
// }
//
// Future<List<Pokemon>> fetchPokemons({int chunkSize = 50}) async {
//   final response = await http.get(
//       Uri.parse('https://pokebuildapi.fr/api/v1/pokemon/limit/$chunkSize'));
//
//   if (response.statusCode == 200) {
//     // Convertir la réponse JSON en une liste d'objets
//     List<dynamic> jsonResponse = json.decode(response.body);
//     List<MonObjet> listeObjets = jsonResponse.map((data) => MonObjet.fromJson(data)).toList();
//
//     // Ordonner la liste par ordre alphabétique du champ 'nom'
//     listeObjets.sort((a, b) => a.nom.compareTo(b.nom));
//
//     // Afficher le résultat
//     listeObjets.forEach((objet) {
//       print(objet.nom);
//     });
//   } else {
//     print('Erreur lors de la récupération des données.');
//   }
// }
