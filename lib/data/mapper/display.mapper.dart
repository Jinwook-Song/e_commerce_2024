import 'package:e_commerce/data/dto/display/menu/menu.dto.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';

extension MenuX on MenuDto {
  Menu toModel() => Menu(tabId: tabIndex, title: title);
}
