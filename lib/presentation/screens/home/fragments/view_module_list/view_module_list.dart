import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart';
import 'package:e_commerce/presentation/screens/home/fragments/footer/footer.dart';
import 'package:e_commerce/presentation/screens/home/fragments/home_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewModuleList extends StatefulWidget {
  final int tabId;

  const ViewModuleList({super.key, required this.tabId});

  @override
  State<ViewModuleList> createState() => _ViewModuleListState();
}

class _ViewModuleListState extends State<ViewModuleList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context
          .read<ViewModuleBloc>()
          .add(ViewModuleInitialized(widget.tabId, isRefresh: true)),
      child: NotificationListener(
        onNotification: (ScrollNotification scrollNotification) {
          final maxScroll = scrollNotification.metrics.maxScrollExtent;
          final curScroll = scrollNotification.metrics.pixels;

          if (curScroll >= maxScroll * (0.9)) {
            context.read<ViewModuleBloc>().add(ViewModuleFetched());
          }

          return false;
        },
        child: BlocBuilder<ViewModuleBloc, ViewModuleState>(
          builder: (context, state) {
            return (state.status.isInitial || state.viewModules.isEmpty)
                ? const HomePlaceholder()
                : ListView.builder(
                    itemCount: state.viewModules.length,
                    itemBuilder: (context, index) {
                      if (index == state.viewModules.length - 1) {
                        return Column(
                          children: [
                            state.viewModules[index],
                            if (state.status.isLoading)
                              const LoadingWidget(isBottom: true),
                            const Footer(),
                          ],
                        );
                      }
                      return state.viewModules[index];
                    },
                  );
          },
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({this.isBottom = false, super.key});

  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    return (isBottom)
        ? const SizedBox(
            height: 50,
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
