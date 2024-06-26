import 'package:e_commerce/core/theme/constant/app_colors.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';

import 'package:flutter/material.dart';

class CustomThemeData {
  static ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: CustomTheme.colorScheme,
        fontFamily: 'Pretendard',
        textTheme: CustomTheme.textTheme,
        dividerTheme: const DividerThemeData(color: AppColors.outline),
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        tabBarTheme: TabBarTheme(
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: CustomTheme.colorScheme.primary,
          labelStyle: CustomTheme.textTheme.titleSmall.semiBold,
          unselectedLabelColor: CustomTheme.colorScheme.contentSecondary,
          unselectedLabelStyle: CustomTheme.textTheme.titleSmall,
          overlayColor: MaterialStatePropertyAll<Color>(
            Colors.grey[300] ?? Colors.grey,
          ),
        ),
      );
}
