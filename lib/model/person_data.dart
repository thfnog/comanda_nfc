import 'package:comanda_nfc/model/product_data.dart';
import 'package:comanda_nfc/model/register.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums/cardType.dart';

part 'person_data.g.dart';

@JsonSerializable()
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

  factory PersonData.fromJson(Map<String, dynamic> json) => _$PersonDataFromJson(json);

  Map<String, dynamic> toJson() => _$PersonDataToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'document': cpf,
      'additionalInfo': {
        'phoneNumber': phoneNumber.toString(),
        'cardId': cardId.toString()
      },
      'uid': uid,
    };
  }
}
