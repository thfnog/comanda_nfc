import 'package:comanda_nfc/model/register.dart';

class ProviderData extends Register {
  final String uid;
  final String providerName;
  final String cnpj;
  final String responsible;
  final String phoneNumber;

  ProviderData(this.uid, {
    required this.providerName,
    required this.cnpj,
    required this.responsible,
    required this.phoneNumber,
  }) : super(uid, {'responsible': responsible, 'phoneNumber': phoneNumber}, name: providerName,
      document: cnpj,
      title: 'Fornecedores');

}
