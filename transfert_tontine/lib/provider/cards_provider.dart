import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CardProvider extends ChangeNotifier {
  late String idCard;

  Future<String> registerCard({
    required String userId,
    required String nameCard,
    required int enteredAmount,
    required int expired,
    required String option,
    required DateTime createdAt,
    required String status,
  }) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance.collection('usersCard').add({
        'userId': userId,
        'nameCard': nameCard,
        'amount': enteredAmount,
        'expired': expired,
        'option': option,
        'status': status,
        'createdAt': createdAt,
      });

      return documentReference.id;
    } catch (e) {
      throw Exception('Erreur de création de carte dans la base de données: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchUserCards() async {
    List<Map<String, dynamic>> userCards = [];

    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? userId = user?.uid;
      if (userId != null) {
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('usersCard').where('userId', isEqualTo: userId).get();

        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((doc) {
            userCards.add(doc.data());
          });
        }
      }
    } catch (e) {
      print('Error fetching user cards: $e');
    }
    return userCards;
  }
}
