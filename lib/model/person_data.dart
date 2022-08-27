import 'package:comanda_nfc/model/product_data.dart';
import 'package:comanda_nfc/model/register.dart';

import 'enums/cardType.dart';

class PersonData extends Register {
  final String cardId;
  final String cpf;
  final String phoneNumber;
  final List<ProductData> products;

  PersonData(uid, {
    this.cardId = '',
    this.phoneNumber = '',
    required name,
    required this.cpf,
    this.products = const <ProductData>[]
  }) : super(uid, additionalInfo: {'cardId': cardId, 'phoneNumber': phoneNumber},
            name: name, document: cpf, type: CardType.clients);
}
