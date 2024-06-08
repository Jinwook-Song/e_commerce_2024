import 'package:e_commerce/data/dto/display/display.dto.dart';
import 'package:e_commerce/data/dto/display/product_info/product_info.dto.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';

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
        products: products?.map((dto) => dto.toModel()).toList() ?? [],
      );
}

extension ProductInfoX on ProductInfoDto {
  ProductInfo toModel() => ProductInfo(
        productId: productId ?? '',
        title: title ?? '',
        subtitle: subtitle ?? '',
        imageUrl: imageUrl ?? '',
        price: price ?? -1,
        originalPrice: originalPrice ?? -1,
        discountRate: discountRate ?? -1,
        reviewCount: reviewCount ?? -1,
      );
}
