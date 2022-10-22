import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_nfc/model/provider_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/enums/cardType.dart';
import '../model/provider_data.dart';
import '../model/register.dart';

class ProviderRepository {

  //static instance of firebase
  static final firebaseInstance = FirebaseFirestore.instance;
  static final User? currentUser = FirebaseAuth.instance.currentUser;

  //collection references
  static final CollectionReference users = firebaseInstance.collection('users');

  saveProvider(Map<String, dynamic> provider) {
    DocumentReference ref = users.doc(currentUser?.uid);
    ref.get().then((value) {
      deleteProviderItemList(value, provider['name'], ref);
      ref.update({'providers': FieldValue.arrayUnion([provider])});
    });
  }

  deleteProvider(String provider) {
    DocumentReference ref = users.doc(currentUser?.uid);
    ref.get().then((value) {
      deleteProviderItemList(value, provider, ref);
    });
  }

  void deleteProviderItemList(DocumentSnapshot<Object?> value, String provider, DocumentReference<Object?> ref) {
    List providers = getProvidersField(value);
    for (var e in providers) {
      if (e['name'] == provider) ref.update({'providers': FieldValue.arrayRemove([e])});
    }
  }

  Stream<List<ProviderData>> getRealtimeProviders() {
    return users.doc(currentUser?.uid).snapshots().map((value) {
      var providersField = getProvidersField(value);
      return providersField.map((e) {
        return ProviderData.fromJson(e);
      }).toList();
    });
  }

  Future<List<ProviderData>> getProviders() { // TODO: Tratar vazio
    return users.doc(currentUser?.uid).get().then((value) {
      var providersField = getProvidersField(value);
      return providersField.map((e) {
        return ProviderData.fromJson(e);
      }).toList();
    });
  }

  List<dynamic> getProvidersField(DocumentSnapshot<Object?> value) {
    var data = value.data() as Map;
    return data['providers'] ?? List.empty();
  }

}
