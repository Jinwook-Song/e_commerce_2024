import 'package:flutter/material.dart';

import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_widget.dart';

class ViewModuleNone extends StatelessWidget with ViewModuleWidget {
  const ViewModuleNone({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(child: Text('ViewModuleNone')),
    );
  }
}
