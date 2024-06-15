import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CommonSnackBar {
  CommonSnackBar();

  static errorSnackBar(BuildContext context, {required ErrorResponse error}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SvgPicture.asset(
              AppIcons.closeCircleFill,
              colorFilter: const ColorFilter.mode(
                AppColors.error,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text('${error.message}'),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static successSnackBar(BuildContext context, {required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SvgPicture.asset(
              AppIcons.checkMark,
              colorFilter: const ColorFilter.mode(
                AppColors.positive,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(msg),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static addCartSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppIcons.cart,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                const Text('상품을 장바구니에 담았습니다.'),
              ],
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                width: 93,
                height: 34,
                child: Center(
                  child: Text(
                    '장바구니 보기',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
              onTap: () {
                context.push(Routes.cartList.name);
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar(reason: SnackBarClosedReason.action);
              },
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
