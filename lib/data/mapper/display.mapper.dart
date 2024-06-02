import 'package:e_commerce/data/dto/display/display.dto.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';

extension MenuX on MenuDto {
  Menu toModel() => Menu(
        tabId: tabId ?? 0,
        title: title ?? '',
      );
}

extension ViewModuleX on ViewModuleDto {
  ViewModule toModel() => ViewModule(
        type: type ?? '',
        title: title ?? '',
        subtitle: subtitle ?? '',
        imageUrl: imageUrl ?? '',
      );
}
