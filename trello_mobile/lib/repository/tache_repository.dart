import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:trello_mobile/repository/abstract_categories.dart';
import 'package:trello_mobile/domains/taches.dart';
import '../http_client.dart';
import 'package:http/http.dart' as http;

import 'dart:io';

class TacheRepositoryIpml extends AbstractRepository<Taches> with ChangeNotifier{
  @override
  Future<List<Taches>> get() async {
    var response = await HttpClient().get("http://localhost/trelloBack/route.php?goto=taches");

    List<dynamic> dataList = json.decode(response.data);

    List<Taches> tachesList = tachesFromJson(dataList);

    return tachesList;
  }

  Future<Map<String, List<Taches>>> getTasksByCategory() async {
    List<Taches> allTasks = await get();

    Map<String, List<Taches>> tasksByCategory = {};

    for (var task in allTasks) {
      if (!tasksByCategory.containsKey(task.categories)) {
        tasksByCategory[task.categories ?? ""] = [];
      }
      tasksByCategory[task.categories]!.add(task);
    }
    return tasksByCategory;
  }


  Future<void> create(Taches taches) async {
    var response = await HttpClient().post(
        'http://localhost/trelloBack/route.php?goto=taches&target=tache_save',
        taches,
        "application/json");
    return response.data;
  }

  Future<List<Taches>> getActive() async {
    var response = await HttpClient().get('http://localhost/trelloBack/route.php?goto=taches&target=tache_active');

    List<dynamic> dataList = jsonDecode(response.data);

    List<Taches> tacheList = tachesFromJson(dataList);
    return tacheList;
  }


  Future<List<Taches>> updateTaskCategory(String? taskName, String? taskDescription, String categoryName) async {
    Map<String, dynamic> taskData = {
      'name': taskName,
      'description': taskDescription,
      'categorie': categoryName,
    };

    var response = await http.post(
      Uri.parse('http://localhost/trelloBack/route.php?goto=taches&target=tache_update'),
      body: jsonEncode(taskData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return tachesFromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<List<Taches>> getTasksForCategory(String categoryName) async {
    var response = await http.post(
        Uri.parse('http://localhost/trelloBack/route.php?goto=taches&target=tache_categorie'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'categorie': categoryName})
    );
    if (response.statusCode == 200) {
      if (response.body.trim().isEmpty) {
        return [];
      }

      List<dynamic> dataList = jsonDecode(response.body);
      try {
        List<Taches> tacheListCategory = tachesFromJson(dataList);
        return tacheListCategory;
      } catch (e) {
        throw Exception("Erreur lors de la conversion du JSON");
      }
    } else {
      throw Exception("Erreur lors de la récupération des tâches pour la catégorie $categoryName : ${response.statusCode}");
    }
  }

}
