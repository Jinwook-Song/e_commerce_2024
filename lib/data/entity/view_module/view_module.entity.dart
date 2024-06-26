import 'package:e_commerce/data/entity/product_info/product_info.entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'view_module.entity.g.dart';

@HiveType(typeId: 2)
class ViewModuleEntity extends HiveObject {
  @HiveField(0, defaultValue: '')
  String type;
  @HiveField(1, defaultValue: '')
  String title;
  @HiveField(2, defaultValue: '')
  String subtitle;
  @HiveField(3, defaultValue: '')
  String imageUrl;
  @HiveField(4, defaultValue: -1)
  int time;
  @HiveField(5, defaultValue: [])
  List<ProductInfoEntity> products;
  @HiveField(6, defaultValue: [])
  List<String> tabs;

  ViewModuleEntity({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.imageUrl,
    required this.time,
    required this.tabs,
    required this.products,
  });
}
