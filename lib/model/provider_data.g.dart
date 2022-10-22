// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderData _$ProviderDataFromJson(Map<String, dynamic> json) => ProviderData(
      json['uid'],
      providerName: json['name'] as String,
      cnpj: json['document'] as String,
      responsible: json['additionalInfo']['responsible'] as String? ?? '',
      phoneNumber: json['additionalInfo']['phoneNumber'] as String? ?? '',
    );

Map<String, dynamic> _$ProviderDataToJson(ProviderData instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'additionalInfo': instance.additionalInfo,
      'providerName': instance.providerName,
      'cnpj': instance.cnpj,
      'responsible': instance.responsible,
      'phoneNumber': instance.phoneNumber,
    };
