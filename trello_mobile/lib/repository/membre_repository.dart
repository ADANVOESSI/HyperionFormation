import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:trello_mobile/repository/abstract_categories.dart';
import 'package:trello_mobile/domains/membres.dart';
import '../http_client.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MembresRepositoryIpml extends AbstractRepository<Membres> with ChangeNotifier {
  Membres? _currentMembres;
  String? _token;

  String? get token => _token;

  Membres? get currentMembre => _currentMembres;

  Future<void> fetchAndSetUser(String token) async {
    final url = 'http://localhost/trelloBack/route.php?goto=membres&target=membre_detail';

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': token,
    });


    final responseData = json.decode(response.body);
    _currentMembres = Membres.fromJson(responseData);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost/trelloBack/route.php?goto=membres&target=login'),
      body: {'email': email, 'password': password},
    );

    final responseData = json.decode(response.body);
    // print(responseData);
    final userData = responseData['user'];
    if (userData == null) {
      throw Exception('User data is missing in the response');
    }

    _currentMembres = Membres.fromJson(userData);
    notifyListeners();

    final nom = userData['nom'];
    final prenoms = userData['prenoms'];

    if (nom == null || prenoms == null) {
      throw Exception('Essential user data (like nom or prenoms) is missing');
    }

  }

  @override
  Future<List<Membres>> get() async {
    var response = await HttpClient().get('http://localhost/trelloBack/route.php?goto=membres');
    List<dynamic> dataList = json.decode(response.data);

    List<Membres> membresLsit = membreFromJson(dataList);
    return membresLsit;
  }

  Future<void> create(Membres membres) async {
    var response = await HttpClient().post(
        'http://localhost/trelloBack/route.php?goto=membres&target=membre_save',
        membres,
        "application/json");
    return response.data;
  }
}
