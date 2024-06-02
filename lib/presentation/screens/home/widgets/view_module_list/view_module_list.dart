import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    itemBuilder: (context, index) => state.viewModules[index],
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}
