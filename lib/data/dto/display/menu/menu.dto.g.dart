// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MenuDtoImpl _$$MenuDtoImplFromJson(Map<String, dynamic> json) =>
    _$MenuDtoImpl(
      title: json['title'] as String? ?? '',
      tabIndex: (json['tabIndex'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$$MenuDtoImplToJson(_$MenuDtoImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'tabIndex': instance.tabIndex,
    };
