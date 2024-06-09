import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:flutter/material.dart';

class ViewModuleSubtitle extends StatelessWidget {
  final String subtitle;

  const ViewModuleSubtitle({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.contentTertiary,
            ),
      ),
    );
  }
}
