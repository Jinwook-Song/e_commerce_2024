import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/presentation/screens/main/fragments/top_app_bar/svg_icon_button.dart';
import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final int quantity;
  final VoidCallback decrease;
  final VoidCallback increase;
  const CounterButton({
    super.key,
    required this.quantity,
    required this.decrease,
    required this.increase,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border.fromBorderSide(
          BorderSide(color: Colors.grey),
        ),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      width: 100,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgIconButton(
            icon: AppIcons.subtract,
            color: (quantity != 1)
                ? Theme.of(context).colorScheme.contentPrimary
                : Theme.of(context).colorScheme.contentFourth,
            onPressed: decrease,
          ),
          Text('$quantity'),
          SvgIconButton(
            icon: AppIcons.add,
            color: Theme.of(context).colorScheme.contentPrimary,
            onPressed: increase,
          ),
        ],
      ),
    );
  }
}
