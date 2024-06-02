import 'package:flutter/material.dart';

import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_widget.dart';

class ViewModuleC extends StatelessWidget with ViewModuleWidget {
  const ViewModuleC({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      height: 200,
      child: const Center(child: Text('ViewModuleC')),
    );
  }
}
