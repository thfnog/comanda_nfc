import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_nfc/model/product_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/enums/cardType.dart';
import '../model/register.dart';

class UserRepository {

  //static instance of firebase
  static final firebaseInstance = FirebaseFirestore.instance;
  static final User? currentUser = FirebaseAuth.instance.currentUser;

  //collection references
  static final CollectionReference users = firebaseInstance.collection('users');

  //add user to users-collection
  Future<void> registerUser(String? uid, String email, String? userName) async {
    Map<String, dynamic> userMap = {
      'uid': uid,
      'email': email,
      'userName': userName
    };
    await users.doc(uid).set(userMap);
  }

  //get user details
  Future<DocumentSnapshot> getUserDetail(String uid) async {
    return await users.doc(uid).get();
  }

}
