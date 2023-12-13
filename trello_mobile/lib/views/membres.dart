// // ignore_for_file: no_logic_in_create_state
//
// import 'package:flutter/material.dart';
// import 'package:trello_mobile/domains/membres.dart';
// import 'package:trello_mobile/repository/membre_repository.dart';
// // import 'dart:math';
//
// class MembresScreen extends StatefulWidget {
//   const MembresScreen({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _MembresState createState() => _MembresState();
// }
//
// class _MembresState extends State<MembresScreen> {
//   // bool _isFlipped = false; // Variable pour suivre l'état du champ de texte
//   String selectedOption = 'Rôle'; // Valeur par défaut sélectionnée
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _prenomController = TextEditingController();
//    String _roleController = 'Rôle';
//   //  List<Membres> membresList = [];
//   final MembresRepositoryIpml repository =MembresRepositoryIpml();
//   _MembresState();
//
//   void _submitForm() async {
//     final MembresRepositoryIpml repository = MembresRepositoryIpml();
//     if (_formKey.currentState!.validate()) {
//       Membres membres = Membres(
//           name: _nameController.text,
//           prenom: _prenomController.text,
//           phone: _prenomController.text,
//           email: _emailController.text,
//           role: _roleController,
//           password:  _roleController,
//       // print(membres.role);
//       // ignore: todo
//       // TODO: Add your logic for form submission here
//
//           await repository.create(membres);
//           _nameController.clear();
//       _prenomController.clear();
//       _emailController.clear();
//       _emailController.clear();
//       _emailController.clear();
//     }
//   }
//
//   void _resetForm() {
//     _formKey.currentState!.reset();
//     _nameController.clear();
//     _prenomController.clear();
//     _emailController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 30,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Mon formulaire d\'inscription :',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w100,
//             color: Color.fromARGB(255, 250, 2, 2),
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Color.fromARGB(255, 0, 0, 0),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     // child: AnimatedContainer(
//                     //   duration:
//                     //       Duration(milliseconds: 500), // Durée de l'animation
//                     //   transform: _isFlipped
//                     //       ? Matrix4.rotationY(math.pi) // Appliquer une rotation de 180 degrés lorsque le champ est "flippé"
//                     //       : Matrix4.rotationY(0), // Sinon, pas de rotation
//                     child: TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Nom :',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Veuillez entrer votre nom';
//                         }
//                         return null;
//                       },
//                       // onTap: () {
//                       //   setState(() {
//                       //     _isFlipped =
//                       //         !_isFlipped; // Inverser l'état lorsque l'utilisateur clique sur le champ
//                       //   });
//                       // },
//                     ),
//                   ),
//                   // ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _prenomController,
//                       decoration: const InputDecoration(
//                         labelText: 'Prénom :',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Veuillez entrer votre prénom';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       // Champ pour l'adresse e-mail
//                       controller: _emailController,
//                       decoration: const InputDecoration(
//                         labelText: 'Email :',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Veuillez entrer votre adresse e-mail';
//                         }
//                         // Ajouter ici une validation pour vérifier si c'est une adresse e-mail valide
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Container(
//                       // controller: _roleController,
//                       margin: const EdgeInsets.only(
//                           bottom: 16), // Ajout de la marge en bas
//                       child: DropdownButtonFormField<String>(
//                         value: _roleController,
//                         onChanged: (newValue) {
//                           setState(() {
//                             _roleController = newValue!;
//                           });
//                         },
//                         items: const [
//                           DropdownMenuItem(
//                             value: 'Rôle',
//                             child: Text('Rôle'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'option1',
//                             child: Text('Front'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'option2',
//                             child: Text('Back'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'option3',
//                             child: Text('Fullstack'),
//                           ),
//                           DropdownMenuItem(
//                             value: 'option4',
//                             child: Text('Base de données'),
//                           ),
//                         ],
//                         decoration: const InputDecoration(
//                           labelText: 'Rôle :',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Veuillez sélectionner une option';
//                           }
//                           // Ajouter ici une validation pour vérifier si c'est une adresse e-mail valide
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: _submitForm,
//                     child: const Text('Valider'),
//                   ),
//                   const SizedBox(width: 16),
//                   ElevatedButton(
//                     onPressed: _resetForm,
//                     child: const Text('Annuler'),
//                   ),
//                 ],
//               ),
//              FutureBuilder<List<Membres>>(
//                 future: repository.get(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Text('No data available');
//                   } else {
//                     return DataTable(
//                       columns: [
//                         DataColumn(label: Text('Nom')),
//                         DataColumn(label: Text('Prénoms')),
//                         DataColumn(label: Text('Email')),
//                         DataColumn(label: Text('Role')),
//                       ],
//                       rows: snapshot.data!.map((member) {
//                         return DataRow(cells: [
//                           DataCell(Text(member.name)),
//                           DataCell(Text(member.prenom)),
//                           DataCell(Text(member.email)),
//                           DataCell(Text(member.role)),
//                         ]);
//                       }).toList(),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
