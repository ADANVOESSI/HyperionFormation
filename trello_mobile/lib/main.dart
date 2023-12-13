import 'package:flutter/material.dart';
import 'package:trello_mobile/repository/categories_repository.dart';
import 'package:trello_mobile/repository/membre_repository.dart';
import 'package:trello_mobile/repository/tache_repository.dart';
import 'package:trello_mobile/routes.dart';
import 'package:provider/provider.dart';


void main() =>  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider<MembresRepositoryIpml>(
        create: (ctx) => MembresRepositoryIpml(),
      ),
      ChangeNotifierProvider<CategoriesRepositoryImpl>(
        create: (ctx) => CategoriesRepositoryImpl(),
      ),
      ChangeNotifierProvider<TacheRepositoryIpml>(
        create: (ctx) => TacheRepositoryIpml(),
      ),
      // ChangeNotifierProvider<AuthProvider>(
      //   create: (ctx) => AuthProvider(),
      // ),
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', // la première route à afficher
      routes: routes,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:trello_mobile/domains/categories.dart';
// import 'package:trello_mobile/domains/taches.dart';
// import 'package:trello_mobile/repository/tache_repository.dart';
// import 'views/Categorie.dart';
// import 'views/membres.dart';
// import 'repository/categories_repository.dart';
// import 'repository/tache_repository.dart';
// import 'repository/membre_repository.dart';
// import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
//
// void main() async {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const MainApp(),
//         '/categorie': (context) => CategorieScreen(
//             title: 'CATEGORIES', repository: CategoriesRepositoryImpl()),
//         '/membre': (context) => MembresScreen(),
//       },
//     );
//   }
// }
//
// class MainApp extends StatelessWidget {
//   const MainApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Menu Example'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//               child: Text('Menu'),
//             ),
//             ListTile(
//               title: const Text('Categorie'),
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, '/categorie');
//               },
//             ),
//             ListTile(
//               title: const Text('Membre'),
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, '/membre');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Navigator(
//         onGenerateRoute: (settings) {
//           WidgetBuilder builder;
//           switch (settings.name) {
//             case '/':
//               builder = (BuildContext context) => HomeScreen();
//               break;
//             case '/categorie':
//               builder = (BuildContext context) => CategorieScreen(
//                   title: 'CATEGORIES', repository: CategoriesRepositoryImpl());
//               break;
//             case '/membre':
//               builder = (BuildContext context) => MembresScreen();
//               break;
//             default:
//               throw Exception('Invalid route: ${settings.name}');
//           }
//           return MaterialPageRoute(builder: builder);
//         },
//       ),
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   final CategoriesRepositoryImpl Mycategories = CategoriesRepositoryImpl();
//   final TacheRepositoryIpml taches = TacheRepositoryIpml();
//
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // List 1: Display taches
//         Container(
//           height: 200, // Set the desired height
//           child: FutureBuilder<List<Taches>>(
//             future: taches.getActive(),
//             builder: (context, snapshot) {
//               // Your existing FutureBuilder code here
//               if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No data available'),
//             );
//           } else {
//             return ListView(
//               scrollDirection: Axis.horizontal,
//               children: snapshot.data!.map((tache) {
//                 if (tache.categories == 'En attente') {
//                   return Container(
//                     // Correcte l'erreur de minuscules dans "Container"
//                     child: Card(
//                         color: Color.fromARGB(255, 251, 245, 244),
//                         child: Column(
//                           children: <Widget>[
//                             SizedBox(
//                               width: 300,
//                               child: Center(
//                                 child: Text(tache.categories),
//                               ),
//                             ),
//                             Card(
//                                 color: Color.fromARGB(255, 138, 193, 221),
//                                 child: Column(children: <Widget>[
//                                   SizedBox(
//                                     width: 250,
//                                     height: 100,
//                                     child: Center(
//                                       child: Text(tache.name),
//                                     ),
//                                   ),
//                                 ])),
//                             ButtonBar(
//                               alignment: MainAxisAlignment
//                                   .center, // Adjust alignment as needed
//                               children: <Widget>[
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Add your button's onPressed logic here
//                                   },
//                                   child: Text('Ajouter une tache'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )),
//                   );
//                 } else {
//                   return Container(
//                     child: Card(
//                       color: Color.fromARGB(255, 251, 245, 244),
//                       child: Column(
//                         children: <Widget>[
//                           SizedBox(
//                             width: 300,
//                             child: Center(
//                               child: Text(tache.categories),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//               }).toList(),
//             );
//           }
//             },
//           ),
//         ),
//
//         // List 2: Display categories
//         Container(
//           height: 200, // Set the desired height
//           child: FutureBuilder<List<Categories>>(
//             future: Mycategories.get(),
//             builder: (context, snapshot) {
//               // Your existing FutureBuilder code here
//               if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No data available'),
//             );
//           } else {
//             return ListView(
//               scrollDirection: Axis.horizontal,
//               children: snapshot.data!.map((categorie) {
//                 if (categorie.name == 'En attente') {
//                   return Container(
//                     // Correcte l'erreur de minuscules dans "Container"
//                     child: Card(
//                         color: Color.fromARGB(255, 251, 245, 244),
//                         child: Column(
//                           children: <Widget>[
//                             SizedBox(
//                               width: 300,
//                               child: Center(
//                                 child: Text(categorie.name),
//                               ),
//                             ),
//                             Card(
//                                 color: Color.fromARGB(255, 138, 193, 221),
//                                 child: Column(children: <Widget>[
//                                   SizedBox(
//                                     width: 250,
//                                     height: 100,
//                                     child: Center(
//                                       child: Text('Nom de la tache'),
//                                     ),
//                                   ),
//                                 ])),
//                             ButtonBar(
//                               alignment: MainAxisAlignment
//                                   .center, // Adjust alignment as needed
//                               children: <Widget>[
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Add your button's onPressed logic here
//                                   },
//                                   child: Text('Ajouter une tache'),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         )),
//                   );
//                 } else {
//                   return Container(
//                     child: Card(
//                       color: Color.fromARGB(255, 251, 245, 244),
//                       child: Column(
//                         children: <Widget>[
//                           SizedBox(
//                             width: 300,
//                             child: Center(
//                               child: Text(categorie.name),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//               }).toList(),
//             );
//           }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }