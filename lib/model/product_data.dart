import 'package:comanda_nfc/model/register.dart';

class ProductData extends Register {
  final String uid;
  final String name;
  final int quantity;
  final double value;
  final String description;

  ProductData({
    this.uid = '',
    this.description = '',
    required this.name,
    required this.quantity,
    required this.value,
  }) : super(uid, {
          'quantity': quantity.toString(),
          'value': value.toStringAsPrecision(2),
          'description': description
        }, name: name, document: '', title: 'Produtos');
}
