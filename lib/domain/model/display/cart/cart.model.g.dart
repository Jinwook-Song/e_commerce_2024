// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartImpl _$$CartImplFromJson(Map<String, dynamic> json) => _$CartImpl(
      product: ProductInfo.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$CartImplToJson(_$CartImpl instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
    };
