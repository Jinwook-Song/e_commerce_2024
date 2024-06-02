import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_widget.dart';
import 'package:flutter/material.dart';

class ViewModuleB extends StatelessWidget with ViewModuleWidget {
  const ViewModuleB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      height: 200,
      child: const Center(child: Text('ViewModuleB')),
    );
  }
}
