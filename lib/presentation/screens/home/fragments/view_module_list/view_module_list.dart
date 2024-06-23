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
    if (_isEndScroll) {
      context.read<ViewModuleBloc>().add(ViewModuleFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context
          .read<ViewModuleBloc>()
          .add(ViewModuleInitialized(widget.tabId, isRefresh: true)),
      child: BlocBuilder<ViewModuleBloc, ViewModuleState>(
        builder: (context, state) {
          return (state.status.isInitial || state.viewModules.isEmpty)
              ? const HomePlaceholder()
              : ListView(
                  controller: _scrollController,
                  children: [
                    ...state.viewModules,
                    if (state.status.isLoading)
                      const LoadingWidget(isBottom: true),
                    const Footer(),
                  ],
                );
        },
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
