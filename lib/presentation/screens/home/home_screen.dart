import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/dialog/common_dialog.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/presentation/screens/home/bloc/menu_bloc/menu_bloc.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:e_commerce/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return BlocProvider(
          create: (_) => MenuBloc(locator<DisplayUsecase>())
            ..add(MenuInitialized(mallType: state)),
          child: const HomeScreenView(),
        );
      },
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MallTypeCubit, MallType>(
      listener: (_, state) =>
          context.read<MenuBloc>().add(MenuInitialized(mallType: state)),
      listenWhen: (prev, cur) => prev.index != cur.index,
      child: BlocConsumer<MenuBloc, MenuState>(
        builder: (_, state) {
          switch (state.status) {
            case Status.initial:
            case Status.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case Status.success:
              return Center(
                child: Text('menu: ${state.menus}'),
              );

            case Status.error:
              return Center(
                child: Text(state.error.message!),
              );
          }
        },
        listener: (context, state) async {
          if (state.status == Status.error) {
            final bool result =
                (await CommonDialog.errorDialog(context, state.error)) ?? false;
            if (result && context.mounted) {
              context.read<MenuBloc>().add(MenuInitialized());
            }
          }
        },
        listenWhen: (prev, curr) => prev.status != curr.status,
      ),
    );
  }
}
