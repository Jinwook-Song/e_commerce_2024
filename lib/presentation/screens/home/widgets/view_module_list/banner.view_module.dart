import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_widget.dart';
import 'package:flutter/material.dart';

class BannerViewModule extends StatelessWidget with ViewModuleWidget {
  final ViewModule info;
  const BannerViewModule(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    if (info.imageUrl.isEmpty) return const SizedBox.shrink();
    return AspectRatio(
      aspectRatio: 375 / 79,
      child: Image.network(
        info.imageUrl,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
