import 'package:comanda_nfc/model/person_data.dart';

class InvoiceData {
  final String uid;
  final DateTime datetime;
  final PersonData personData;
  final double totalAmount;
  final bool paid;

  InvoiceData(
      {this.uid = '',
      DateTime? datetime,
      PersonData? personData,
      double? totalAmount,
      this.paid = false})
      : datetime = datetime ?? DateTime.now(),
        personData = personData ?? PersonData(name: '', cpf: ''),
        totalAmount = totalAmount ?? 0;

}
