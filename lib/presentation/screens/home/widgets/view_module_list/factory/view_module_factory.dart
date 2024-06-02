import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_widget.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/view_module_A.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/view_module_B.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/view_module_C.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/view_module_D.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/view_module_E.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/view_module_NONE.dart';
import 'package:flutter/material.dart';

enum Modules {
  viewModuleA,
  viewModuleB,
  viewModuleC,
  viewModuleD,
  viewModuleE,
}

class ViewModuleFactory {
  Widget textToWidget(ViewModule viewModule) {
    final String type = viewModule.type.toSnakeCase();
    for (final module in Modules.values) {
      final name = module.name.toSnakeCase();
      if (name.contains(type)) {
        return module.toWidget(viewModule) as Widget;
      }
    }

    return const ViewModuleNone();
  }
}

extension ModulesEx on Modules {
  ViewModuleWidget toWidget(ViewModule info) {
    switch (this) {
      case Modules.viewModuleA:
        return const ViewModuleA();
      case Modules.viewModuleB:
        return const ViewModuleB();
      case Modules.viewModuleC:
        return const ViewModuleC();
      case Modules.viewModuleD:
        return const ViewModuleD();
      case Modules.viewModuleE:
        return const ViewModuleE();
    }
  }
}
