import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_nfc/repositories/product_repository.dart';
import 'package:comanda_nfc/repositories/provider_repository.dart';
import 'package:comanda_nfc/repositories/user_repository.dart';

import '../model/enums/cardType.dart';
import '../model/register.dart';
import 'client_repository.dart';

class CloudFunctions {

  //add user to users-collection
  Future<void> registerUser(String? uid, String email, String? userName) async {
    await UserRepository().registerUser(uid, email, userName);
  }

  //get user details
  Future<DocumentSnapshot> getUserDetail(String uid) async {
    return await UserRepository().getUserDetail(uid);
  }

  Stream<List<Register>> getByCardType(CardType? cardType) {
    switch (cardType) {
      case CardType.products:
        return ProductRepository().getRealtimeProducts();
      case CardType.clients:
        return ClientRepository().getRealtimeClients();
      case CardType.providers:
        return ProviderRepository().getRealtimeProviders();
      default:
        return Stream.empty();
    }
  }

  saveByCardType(CardType cardType, Map<String, dynamic> register) {
    switch (cardType) {
      case CardType.products:
        return ProductRepository().saveProduct(register);
      case CardType.clients:
        return ClientRepository().saveClient(register);
      case CardType.providers:
        return ProviderRepository().saveProvider(register);
      default:
        return Stream.empty();
    }
  }

  deleteByCardType(CardType cardType, String register) {
    switch (cardType) {
      case CardType.products:
        return ProductRepository().deleteProduct(register);
      case CardType.clients:
        return ClientRepository().deleteClient(register);
      case CardType.providers:
        return ProviderRepository().deleteProvider(register);
      default:
        return Stream.empty();
    }
  }

}
