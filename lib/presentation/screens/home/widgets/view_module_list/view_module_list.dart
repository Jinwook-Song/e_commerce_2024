import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewModuleList extends StatefulWidget {
  const ViewModuleList({super.key});

  @override
  State<ViewModuleList> createState() => _ViewModuleListState();
}

class _ViewModuleListState extends State<ViewModuleList> {
  final ScrollController _scrollController = ScrollController();

  bool get _isEndScroll {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currScroll = _scrollController.offset;
    return currScroll > maxScroll * 0.9;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    logging(_isEndScroll);
    if (_isEndScroll) {
      context.read<ViewModuleBloc>().add(ViewModuleFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewModuleBloc, ViewModuleState>(
      builder: (context, state) {
        return (state.status.isInitial || state.viewModules.isEmpty)
            ? const LoadingWidget()
            : ListView(
                controller: _scrollController,
                children: [
                  ...state.viewModules,
                  if (state.status.isLoading)
                    const LoadingWidget(isBottom: true),
                ],
              );
        // switch (state.status) {
        //   case Status.initial:
        //   case Status.loading:
        //     return const Center(
        //       child: CircularProgressIndicator.adaptive(),
        //     );
        //   case Status.error:
        //     return const Center(
        //       child: Text('Error'),
        //     );
        //   case Status.success:
        //     return Column(
        //       children: [
        //         Container(
        //           height: 50,
        //           color: Colors.deepOrangeAccent,
        //           child: Center(
        //             child: Text(state.tabId.toString()),
        //           ),
        //         ),
        //         Expanded(
        //           child: ListView.separated(
        //             itemCount: state.viewModules.length,
        //             separatorBuilder: (context, index) => const Divider(),
        //             itemBuilder: (context, index) => state.viewModules[index],
        //           ),
        //         ),
        //       ],
        //     );
        // }
      },
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
