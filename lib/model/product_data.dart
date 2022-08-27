import 'package:comanda_nfc/model/register.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums/cardType.dart';

part 'product_data.g.dart';

@JsonSerializable()
class ProductData extends Register {
  final int quantity;
  final double value;
  final String description;

  ProductData(uid, {
    this.description = '',
    required name,
    required this.quantity,
    required this.value,
  }) : super(
            uid,
            additionalInfo: {
              'quantity': quantity.toString(),
              'value': value.toStringAsPrecision(2),
              'description': description
            },
            name: name,
            document: '',
            type: CardType.products);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'additionalInfo': {
        'quantity': quantity.toString(),
        'value': value.toStringAsPrecision(2),
        'description': description
      },
      'uid': uid,
    };
  }

  factory ProductData.fromJson(Map<String, dynamic> json) => _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);

}
