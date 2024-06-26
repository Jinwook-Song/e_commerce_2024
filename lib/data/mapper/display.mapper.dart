import 'package:e_commerce/data/dto/display/display.dto.dart';
import 'package:e_commerce/data/dto/display/product_info/product_info.dto.dart';
import 'package:e_commerce/data/entity/cart/cart.entity.dart';
import 'package:e_commerce/data/entity/product_info/product_info.entity.dart';
import 'package:e_commerce/data/entity/view_module/view_module.entity.dart';
import 'package:e_commerce/domain/model/display/cart/cart.model.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/domain/model/display/product_info/product_info.model.dart';

extension MenuDtoEx on MenuDto {
  Menu toModel() => Menu(
        tabId: tabId ?? 0,
        title: title ?? '',
      );
}

extension ViewModuleDtoEx on ViewModuleDto {
  ViewModule toModel() => ViewModule(
        type: type ?? '',
        title: title ?? '',
        subtitle: subtitle ?? '',
        imageUrl: imageUrl ?? '',
        time: time ?? -1,
        products: products?.map((dto) => dto.toModel()).toList() ?? [],
        tabs: tabs ?? [],
      );
}

/// ENTITY -> MODEL
extension ViewModuleEntityEx on ViewModuleEntity {
  ViewModule toModel() {
    return ViewModule(
      type: type,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      time: time,
      products: products.map((entity) => entity.toModel()).toList(),
      tabs: tabs,
    );
  }
}

/// MODEL -> ENTITY
extension ViewModuleEx on ViewModule {
  ViewModuleEntity toEntity() {
    return ViewModuleEntity(
      type: type,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      time: time,
      products: products.map((model) => model.toEntity()).toList(),
      tabs: tabs,
    );
  }
}

extension ProductInfoDtoEx on ProductInfoDto {
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

/// MODEL -> ENTITY
extension ProductInfoEx on ProductInfo {
  ProductInfoEntity toEntity() {
    return ProductInfoEntity(
      productId: productId,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      price: price,
      originalPrice: originalPrice,
      discountRate: discountRate,
      reviewCount: reviewCount,
    );
  }
}

/// Entity -> MODEL
extension ProductInfoEntityEx on ProductInfoEntity {
  ProductInfo toModel() {
    return ProductInfo(
      productId: productId,
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      price: price,
      originalPrice: originalPrice,
      discountRate: discountRate,
      reviewCount: reviewCount,
    );
  }
}

/// Entity -> MODEL
extension CartEntityEx on CartEntity {
  Cart toModel() {
    return Cart(quantity: quantity, product: product.toModel());
  }
}

extension CartEx on Cart {
  CartEntity toEntity() {
    return CartEntity(product: product.toEntity(), quantity: quantity);
  }
}
