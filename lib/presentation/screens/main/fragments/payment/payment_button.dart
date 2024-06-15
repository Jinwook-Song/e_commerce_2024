import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/domain/model/display/cart/cart.model.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final List<Cart> selectedCartList;
  final int totalPrice;

  const PaymentButton({
    super.key,
    required this.selectedCartList,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.horizontalPadding,
      child: SizedBox(
        height: 48,
        child: TextButton(
          // TODO: payment button
          onPressed: null,
          style: TextButton.styleFrom(
            backgroundColor: selectedCartList.isNotEmpty
                ? Theme.of(context).primaryColor
                : Colors.grey[400] ?? Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Center(
            child: Text(
              selectedCartList.isNotEmpty
                  ? '${totalPrice.toWon()} 결제하기'
                  : '상품을 선택해주세요',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
