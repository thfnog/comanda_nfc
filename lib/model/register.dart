import 'enums/cardType.dart';

abstract class Register {

  final String uid;
  final CardType type;
  final String name;
  final String document;
  final Map<String, String> additionalInfo;

  Register(this.uid, {
    this.additionalInfo = const {},
    required this.type,
    required this.name,
    required this.document
  });

}
