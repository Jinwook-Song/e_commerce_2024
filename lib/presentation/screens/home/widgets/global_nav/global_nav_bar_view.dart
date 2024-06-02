import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/view_module_list.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:e_commerce/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          (index) {
            return BlocProvider(
              create: (context) => locator<ViewModuleBloc>()
                ..add(ViewModuleInitialized(menus[index].tabId)),
              child: const ViewModuleList(),
            );
          },
        ),
      ),
    );
  }
}
