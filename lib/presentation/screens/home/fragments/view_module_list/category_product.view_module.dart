import 'package:e_commerce/core/theme/constant/app_icons.dart';
import 'package:e_commerce/core/theme/custom/custom_font_weight.dart';
import 'package:e_commerce/core/theme/custom/custom_theme.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_widget.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/product_card.component.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_padding.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/widgets/view_module_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CategoryProductViewModule extends StatefulWidget with ViewModuleWidget {
  final ViewModule info;
  const CategoryProductViewModule(this.info, {super.key});

  @override
  State<CategoryProductViewModule> createState() =>
      _CategoryProductViewModuleState();
}

class _CategoryProductViewModuleState extends State<CategoryProductViewModule>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: widget.info.tabs.length, vsync: this)
        ..addListener(() {
          setState(() {});
        });

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final info = widget.info;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewModulePadding(
          child: ViewModuleTitle(title: info.title),
        ),
        const Gap(12),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 13),
          dividerColor: Colors.transparent,
          tabs: List.generate(
            info.tabs.length,
            (index) => Tab(
              text: info.tabs[index],
            ),
          ),
        ),
        const Gap(12),
        Padding(
          padding: Constants.horizontalPadding,
          child: AspectRatio(
            aspectRatio: 343 / 452,
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                info.tabs.length,
                (index) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                      childAspectRatio: ((343 - 16) / 3) / ((452 - 12) / 2),
                    ),
                    itemCount: info.products.length,
                    itemBuilder: (_, index) {
                      final productInfo = info.products[index];
                      return SmallProductCard(
                        context,
                        productInfo: productInfo,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        const Gap(12),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: Constants.horizontalPadding,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${info.tabs[_tabController.index]} 전체보기',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(
                        color: colorScheme.contentPrimary,
                      )
                      .regular,
                ),
                SvgPicture.asset(
                  AppIcons.chevronRight,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    colorScheme.contentPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(50),
      ],
    );
  }
}
