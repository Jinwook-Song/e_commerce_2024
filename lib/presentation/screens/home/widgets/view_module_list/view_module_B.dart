import 'package:flutter/material.dart';

import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_widget.dart';

class ViewModuleA extends StatelessWidget with ViewModuleWidget {
  const ViewModuleA({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 200,
      child: const Center(child: Text('ViewModuleA')),
    );
  }
}
