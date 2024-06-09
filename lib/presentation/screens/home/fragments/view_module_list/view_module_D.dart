import 'package:flutter/material.dart';

import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_widget.dart';

class ViewModuleD extends StatelessWidget with ViewModuleWidget {
  const ViewModuleD({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: 200,
      child: const Center(child: Text('ViewModuleD')),
    );
  }
}
