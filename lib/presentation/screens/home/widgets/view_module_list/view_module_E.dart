import 'package:flutter/material.dart';

import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_widget.dart';

class ViewModuleE extends StatelessWidget with ViewModuleWidget {
  const ViewModuleE({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      height: 200,
      child: const Center(child: Text('ViewModuleE')),
    );
  }
}
