import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_nfc/model/product_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/enums/cardType.dart';
import '../model/register.dart';

class CloudFunctions {
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

  Stream<List<Register>> getByCardType(CardType? cardType) {
    switch (cardType) {
      case CardType.products:
        return getRealtimeProducts();
      case CardType.clients:
        return Stream.empty();
      case CardType.providers:
        return Stream.empty();
      default:
        return Stream.empty();
    }
  }

  saveByCardType(CardType cardType, Map<String, dynamic> register) {
    switch (cardType) {
      case CardType.products:
        return saveProduct(register);
      case CardType.clients:
        return Stream.empty();
      case CardType.providers:
        return Stream.empty();
      default:
        return Stream.empty();
    }
  }

  /// ### Products

  saveProduct(Map<String, dynamic> product) {
    DocumentReference ref = users.doc(currentUser?.uid);
    ref.get().then((value) {
      List products = getProductsField(value);
      for (var e in products) {
        if (e['name'] == product['name']) ref.update({'products': FieldValue.arrayRemove([e])});
      }
      ref.update({'products': FieldValue.arrayUnion([product])});
    });
  }

  Stream<List<ProductData>> getRealtimeProducts() { // TODO: Tratar vazio
    return users.doc(currentUser?.uid).snapshots().map((value) {
      var productsField = getProductsField(value);
      return productsField.map((e) {
        return ProductData.fromJson(e);
      }).toList();
    });
  }

  Future<List<ProductData>> getProducts() { // TODO: Tratar vazio
    return users.doc(currentUser?.uid).get().then((value) {
      var productsField = getProductsField(value);
      return productsField.map((e) {
        return ProductData.fromJson(e);
      }).toList();
    });
  }

  List<dynamic> getProductsField(DocumentSnapshot<Object?> value) {
    var data = value.data() as Map;
    return data['products'];
  }

  Future<void> removeProduct(ProductData productData) async {
    users.doc(currentUser?.uid).update({
      'products': FieldValue.arrayRemove([productData.toMap()])
    });
  }

}
