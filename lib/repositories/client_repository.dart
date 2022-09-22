import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/person_data.dart';

class ClientRepository {

  //static instance of firebase
  static final firebaseInstance = FirebaseFirestore.instance;
  static final User? currentUser = FirebaseAuth.instance.currentUser;

  //collection references
  static final CollectionReference users = firebaseInstance.collection('users');

  saveClient(Map<String, dynamic> client) {
    DocumentReference ref = users.doc(currentUser?.uid);
    ref.get().then((value) {
      deleteClientItemList(value, client['name'], ref);
      ref.update({'clients': FieldValue.arrayUnion([client])});
    });
  }

  deleteClient(String client) {
    DocumentReference ref = users.doc(currentUser?.uid);
    ref.get().then((value) {
      deleteClientItemList(value, client, ref);
    });
  }

  void deleteClientItemList(DocumentSnapshot<Object?> value, String client, DocumentReference<Object?> ref) {
    List clients = getClientsField(value);
    for (var e in clients) {
      if (e['name'] == client) ref.update({'clients': FieldValue.arrayRemove([e])});
    }
  }

  Stream<List<PersonData>> getRealtimeClients() { // TODO: Tratar vazio
    return users.doc(currentUser?.uid).snapshots().map((value) {
      var clientsField = getClientsField(value);
      return clientsField.map((e) {
        return PersonData.fromJson(e);
      }).toList();
    });
  }

  Future<List<PersonData>> getClients() { // TODO: Tratar vazio
    return users.doc(currentUser?.uid).get().then((value) {
      var clientsField = getClientsField(value);
      return clientsField.map((e) {
        return PersonData.fromJson(e);
      }).toList();
    });
  }

  List<dynamic> getClientsField(DocumentSnapshot<Object?> value) {
    var data = value.data() as Map;
    return data['clients'] ?? List.empty();
  }

}
