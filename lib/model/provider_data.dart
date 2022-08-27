import 'package:comanda_nfc/model/register.dart';

import 'enums/cardType.dart';

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

}
