// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonData _$PersonDataFromJson(Map<String, dynamic> json) => PersonData(
      json['uid'],
      cardId: json['additionalInfo']['cardId'] as String? ?? '',
      phoneNumber: json['additionalInfo']['phoneNumber'] as String? ?? '',
      name: json['name'],
      cpf: json['document'] as String,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ProductData>[],
    );

Map<String, dynamic> _$PersonDataToJson(PersonData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'additionalInfo': instance.additionalInfo,
      'name': instance.name,
      'cardId': instance.cardId,
      'cpf': instance.cpf,
      'phoneNumber': instance.phoneNumber,
      'products': instance.products,
    };
