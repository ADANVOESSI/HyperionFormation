import 'package:flutter/material.dart';
import 'package:trello_mobile/domains/categories.dart';
import 'package:trello_mobile/domains/taches.dart';
import 'package:trello_mobile/repository/categories_repository.dart';
import 'package:trello_mobile/repository/membre_repository.dart';
import 'package:provider/provider.dart';
import 'package:trello_mobile/repository/tache_repository.dart';

class TrelloPage extends StatefulWidget {
  const TrelloPage({Key? key}) : super(key: key);

  @override
  State<TrelloPage> createState() => _TrelloPageState();
}

class _TrelloPageState extends State<TrelloPage> {
  Map<String, List<Taches>> tasksByCategory = {};
  TacheRepositoryIpml repository = TacheRepositoryIpml();

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<MembresRepositoryIpml>(
        context);
    final categoriesRepo = Provider.of<CategoriesRepositoryImpl>(
        context);
    final tacheRepository = Provider.of<TacheRepositoryIpml>(context);

    final user = authController.currentMembre;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan.shade50,

      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 00.0),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/bg1.jpg'),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user?.name}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        "${user?.prenom}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    iconSize: 35.0,
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Text("La liste des tâches de tous les utilisateurs connectés",
                style: TextStyle(
                  fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                ),
              ),


      SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 10.0),
          child: PhysicalShape(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            elevation: 16,
            color: Colors.white,
              child: FutureBuilder<List<Categories>>(
                future: categoriesRepo.get(),
                builder: (context, categoriesSnapshot) {
                  if (categoriesSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (categoriesSnapshot.hasError) {
                    return Center(child: Text("Erreur lors de la récupération des catégories"));
                  } else if (categoriesSnapshot.hasData) {
                    return FutureBuilder<Map<String, List<Taches>>>(
                      future: tacheRepository.getTasksByCategory(),
                      builder: (context, tasksSnapshot) {
                        if (tasksSnapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (tasksSnapshot.hasError) {
                          return Center(child: Text("Une erreur s'est produite"));
                        } else if (tasksSnapshot.hasData) {
                          Map<String, List<Taches>> combinedMap = {};
                          for (var category in categoriesSnapshot.data!) {
                            combinedMap[category.name] = tasksSnapshot.data![category.name] ?? [];
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: combinedMap.keys.map((categorieName) {
                                List<Taches> tasksForCategory = combinedMap[categorieName] ?? [];
                                return buildCategoryColumn(categorieName, tasksForCategory);
                              }).toList(),
                            ),
                          );
                        } else {
                          return const Center(child: Text("Aucune tâche trouvée pour les catégories"));
                        }
                      },
                    );
                  } else {
                    return const Center(child: Text("Aucune catégorie trouvée"));
                  }
                },
              ),
          ),
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryColumn(String categoryName, List<Taches> tasksForCategory) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: 150.0,
      height: height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 10.0),
          child: PhysicalShape(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            elevation: 16,
            color: Colors.white,
            child: DragTarget<Taches>(
              onWillAccept: (data) => true,
              onAccept: (data) async {
                print("Début de onAccept");

                setState(() {
                  print("Avant remove");
                  tasksForCategory.remove(data);
                  print("Après remove");

                  print("Avant add");
                  if (tasksByCategory[categoryName] == null) {
                    tasksByCategory[categoryName] = [data];
                  } else {
                    tasksByCategory[categoryName]!.add(data);
                  }
                  print("Après add");
                });

                print("Avant updateTaskCategory");
                try {
                  await repository.updateTaskCategory(data.name!, data.description!, categoryName);
                  print("Mise à jour réussie!");
                } catch (error) {
                  print("Erreur lors de la mise à jour: $error");
                }
                print("Fin de onAccept");
              },
              builder: (context, incoming, rejected) {
                double height = MediaQuery.of(context).size.height - 15;

                return Container(
                  height: height,
                  child: Column(
                    children: [
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                      Expanded(  // Ajouté pour s'assurer que les éléments fils prennent tout l'espace restant
                        child: ListView(
                          children: tasksForCategory.map((task) => buildDraggableTask(task)).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }



  Widget buildDraggableTask(Taches task) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: PhysicalShape(
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          elevation: 16,
          color: Colors.white,
          child: Draggable<Taches>(
            data: task,
            child: Container(
              width: double.infinity,
              // height: 190.0,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.orangeAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom: ${task.name ?? ''}'),
                  SizedBox(height: 4),
                  Text('Description: ${task.description ?? ''}'),
                  SizedBox(height: 4),
                  Text('Membre: ${task.membres ?? ''}'),
                ],
              ),
            ),
            feedback: Material(
              elevation: 5.0,
                child: Container(
                  width: 150.0,
                  height: 170.0,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.orangeAccent),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom: ${task.name ?? ''}'),
                      SizedBox(height: 4),
                      Text('Description: ${task.description ?? ''}'),
                      SizedBox(height: 4),
                      Text('Membre: ${task.membres ?? ''}'),
                    ],
                  ),
                ),
            ),
            childWhenDragging: Container(
              width: 150.0,
              height: 170.0,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.orangeAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nom: ${task.name ?? ''}'),
                  SizedBox(height: 4),
                  Text('Description: ${task.description ?? ''}'),
                  SizedBox(height: 4),
                  Text('Membre: ${task.membres ?? ''}'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


