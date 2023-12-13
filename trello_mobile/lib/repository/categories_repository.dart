import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../http_client.dart';
import 'package:trello_mobile/repository/abstract_categories.dart';
import 'package:trello_mobile/domains/categories.dart';

class CategoriesRepositoryImpl extends AbstractRepository<Categories> with ChangeNotifier{
  @override
  Future<List<Categories>> get() async {
    var response = await HttpClient().get("http://localhost/trelloBack/route.php?goto=categories");

    List<dynamic> dataList = json.decode(response.data);

    List<Categories> categorieList = categorieFromJson(dataList);

    return categorieList;
  }

  Future<void> create(Categories categorie) async {
    var response = await HttpClient().post(
        "http://localhost/trelloBack/route.php?goto=categories&target=categorie_save",
        categorie,
        "application/json");
    return response.data;
  }
}
