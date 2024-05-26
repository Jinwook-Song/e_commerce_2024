import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:flutter/material.dart';

class GlobalNavBarView extends StatelessWidget {
  final List<Menu> menus;
  final MallType mallType;
  const GlobalNavBarView({
    super.key,
    required this.menus,
    required this.mallType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: List.generate(
          menus.length,
          (index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('type: $mallType'),
              Text('menu: ${menus[index].title}'),
            ],
          ),
        ),
      ),
    );
  }
}
