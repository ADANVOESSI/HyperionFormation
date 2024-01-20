import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAuthProvider extends ChangeNotifier {
  late String uid;
  late String phoneNumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> onVerifySmsCode({
    required String verificationIDReceive,
    required String smsCode,
    required BuildContext context,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIDReceive,
      smsCode: smsCode,
    );

    try {
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      uid = userCredential.user!.uid;
      phoneNumber = userCredential.user!.phoneNumber!;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('users').where('userId', isEqualTo: uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        Navigator.of(context).pushReplacementNamed('/homeScreen');
      } else {
        Navigator.of(context).pushReplacementNamed('/inscription');
      }
      notifyListeners();
    } catch (e) {
      print("Erreur lors de la vérification du code SMS : $e");
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDocument = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDocument.exists) {
        return userDocument.data();
      } else {
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération des données de l'utilisateur : $e");
      return null;
    }
  }

  Future<void> registerUser({
    required String userId,
    required String nom,
    required String prenom,
    required String email,
    String? phoneNumber,
    required String adresse,
    String? typePiece,
    String? numPiece,
    DateTime? createdAt,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'userId': userId,
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'userContact': phoneNumber,
        'adresse': adresse,
        'type_piece': typePiece,
        'num_piece': numPiece,
        'createdAt': createdAt,
      });
    } catch (e) {
      throw Exception("Erreur d'ajout d'utilisateur dans la base de données: $e");
    }
  }

  Future<void> registerUserProche({
    required String userId,
    required String nom,
    required String prenom,
    required String email,
    String? phoneNumber,
    required String adresse,
    String? typePiece,
    String? numPiece,
    DateTime? createdAt,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('usersProche').add({
        'userId': userId,
        'fNameUserProche': nom,
        'lNameUserProche': prenom,
        'emailUserProche': email,
        'userProcheContact': phoneNumber,
        'adresseUserProche': adresse,
        'type_pieceUserProche': typePiece,
        'num_pieceUserProche': numPiece,
        'createdAt': createdAt,
      });
    } catch (e) {
      throw Exception("Erreur d'ajout d'utilisateur dans la base de données: $e");
    }
  }

  Future<void> validateOtp(String smsCode, String verificationId) async {
    final _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(_credential);
    return;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }

  User? get user => _auth.currentUser;
}
