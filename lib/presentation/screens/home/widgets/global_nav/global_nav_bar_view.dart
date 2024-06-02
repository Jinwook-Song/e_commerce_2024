import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:e_commerce/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalNavBarView extends StatelessWidget {
  final List<Menu> menus;
  final MallType mallType;
  const GlobalNavBarView({
    super.key,
    required this.menus,
    required this.mallType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: List.generate(
          menus.length,
          (index) {
            return BlocProvider(
              create: (context) => ViewModuleBloc(locator<DisplayUsecase>())
                ..add(ViewModuleInitialized(menus[index].tabId)),
              child: const ViewModuleList(),
            );
          },
        ),
      ),
    );
  }
}

class ViewModuleList extends StatelessWidget {
  const ViewModuleList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewModuleBloc, ViewModuleState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.initial:
          case Status.loading:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          case Status.error:
            return const Center(
              child: Text('Error'),
            );
          case Status.success:
            return Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.deepOrangeAccent,
                  child: Center(
                    child: Text(state.tabId.toString()),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.viewModules.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(state.viewModules[index].title),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
