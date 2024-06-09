import 'package:e_commerce/core/utils/constants.dart';
import 'package:flutter/material.dart';

class ViewModulePadding extends StatelessWidget {
  final Widget child;
  const ViewModulePadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.horizontalPadding,
      child: child,
    );
  }
}
