import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.dto.freezed.dart';
part 'menu.dto.g.dart';

@freezed
class MenuDto with _$MenuDto {
  const factory MenuDto({
    @Default('') String? title,
    @Default(-1) int? tabIndex,
  }) = _MenuDto;

  factory MenuDto.fromJson(Map<String, dynamic> json) =>
      _$MenuDtoFromJson(json);
}
