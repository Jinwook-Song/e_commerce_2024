import 'package:freezed_annotation/freezed_annotation.dart';

part 'viee_module.model.freezed.dart';
part 'viee_module.model.g.dart';

@freezed
class ViewModule with _$ViewModule {
  const factory ViewModule({
    required String type,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) = _ViewModule;

  factory ViewModule.fromJson(Map<String, dynamic> json) =>
      _$ViewModuleFromJson(json);
}
