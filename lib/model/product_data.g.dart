// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductData _$ProductDataFromJson(Map<String, dynamic> json) {
      var productData = ProductData(
            json['uid'],
            description: json['additionalInfo']['description'] as String? ?? '',
            name: json['name'],
            quantity: int.tryParse(json['additionalInfo']['quantity'] ?? '0') ?? 0,
            value: double.tryParse(json['additionalInfo']['value'] ?? '0') ?? 0.0,
      );

      return productData;
}

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'additionalInfo': instance.additionalInfo,
      'name': instance.name,
      'quantity': instance.quantity,
      'value': instance.value,
      'description': instance.description,
    };
