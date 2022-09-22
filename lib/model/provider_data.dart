import 'package:comanda_nfc/model/register.dart';
import 'package:json_annotation/json_annotation.dart';

import 'enums/cardType.dart';

part 'provider_data.g.dart';

@JsonSerializable()
class ProviderData extends Register {
  final String providerName;
  final String cnpj;
  final String responsible;
  final String phoneNumber;

  ProviderData(uid, {
    required this.providerName,
    required this.cnpj,
    required this.responsible,
    required this.phoneNumber,
  }) : super(uid, additionalInfo: {'responsible': responsible, 'phoneNumber': phoneNumber}, name: providerName,
      document: cnpj,
      type: CardType.providers);

  factory ProviderData.fromJson(Map<String, dynamic> json) => _$ProviderDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderDataToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'document': cnpj,
      'additionalInfo': {
        'phoneNumber': phoneNumber.toString(),
        'responsible': responsible.toString()
      },
      'uid': uid,
    };
  }

}
