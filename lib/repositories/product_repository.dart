import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_nfc/model/product_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/enums/cardType.dart';
import '../model/register.dart';

class ProductRepository {

  //static instance of firebase
  static final firebaseInstance = FirebaseFirestore.instance;
  static final User? currentUser = FirebaseAuth.instance.currentUser;

  //collection references
  static final CollectionReference users = firebaseInstance.collection('users');

  saveProduct(Map<String, dynamic> product) {
    DocumentReference ref = users.doc(currentUser?.uid);
    ref.get().then((value) {
      deleteProductItemList(value, product['name'], ref);
      ref.update({'products': FieldValue.arrayUnion([product])});
    });
  }

  deleteProduct(String product) {
    DocumentReference ref = users.doc(currentUser?.uid);
    ref.get().then((value) {
      deleteProductItemList(value, product, ref);
    });
  }

  void deleteProductItemList(DocumentSnapshot<Object?> value, String product, DocumentReference<Object?> ref) {
    List products = getProductsField(value);
    for (var e in products) {
      if (e['name'] == product) ref.update({'products': FieldValue.arrayRemove([e])});
    }
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
    return data['products'] ?? List.empty();
  }

  Future<void> removeProduct(ProductData productData) async {
    users.doc(currentUser?.uid).update({
      'products': FieldValue.arrayRemove([productData.toMap()])
    });
  }

}
