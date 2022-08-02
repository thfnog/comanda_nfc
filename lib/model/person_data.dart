import 'package:comanda_nfc/model/product_data.dart';
import 'package:comanda_nfc/model/register.dart';

class PersonData extends Register {
  final String uid;
  final String name;
  final String cardId;
  final String cpf;
  final String phoneNumber;
  final List<ProductData> products;

  PersonData({
    this.uid = '',
    this.cardId = '',
    this.phoneNumber = '',
    required this.name,
    required this.cpf,
    this.products = const <ProductData>[]
  }) : super(uid, {'cardId': cardId, 'phoneNumber': phoneNumber},
            name: name, document: cpf, title: 'Clientes');
}
