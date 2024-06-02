import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/domain/usecase/display/view_module/get_view_modules.usecase.dart';
import 'package:e_commerce/presentation/screens/home/widgets/view_module_list/factory/view_module_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_module_event.dart';
part 'view_module_state.dart';
part 'view_module_bloc.freezed.dart';

class ViewModuleBloc extends Bloc<ViewModuleEvent, ViewModuleState> {
  final DisplayUsecase _displayUsecase;

  ViewModuleBloc(this._displayUsecase) : super(ViewModuleState()) {
    on<ViewModuleInitialized>(_onViewModuleInitialized);
    on<ViewModuleFetched>(_onViewModuleFetched);
  }

  Future<Result<List<ViewModule>>> _fetch(int tabId, [int page = 1]) async {
    return await _displayUsecase.execute(
      usecase: GetViewModulesUsecase(tabId: tabId, page: page),
    );
  }

  Future<void> _onViewModuleInitialized(
    ViewModuleInitialized event,
    Emitter<ViewModuleState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final int tabId = event.tabId;

    try {
      final response = await _fetch(tabId);
      response.when(
        success: (viewModules) {
          ViewModuleFactory viewModuleFactory = ViewModuleFactory();

          emit(
            state.copyWith(
              status: Status.success,
              tabId: tabId,
              viewModules: viewModules.map(
                (viewModule) {
                  return viewModuleFactory.textToWidget(viewModule);
                },
              ).toList(),
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (e) {
      logging(e, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(e),
        ),
      );
    }
  }

  Future<void> _onViewModuleFetched(
    ViewModuleFetched event,
    Emitter<ViewModuleState> emit,
  ) async {
    if (state.isEndOfPage) return;
    final nextPage = state.currentPage + 1;
    final tabId = state.tabId;

    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _fetch(tabId, nextPage);
      response.when(
        success: (viewModules) {
          if (viewModules.isEmpty) {
            emit(
              state.copyWith(
                status: Status.success,
                currentPage: nextPage,
                isEndOfPage: true,
              ),
            );
            return;
          }

          ViewModuleFactory viewModuleFactory = ViewModuleFactory();

          final viewModuleList = [...state.viewModules];
          viewModuleList.addAll(
            List.generate(
              viewModules.length,
              (index) => viewModuleFactory.textToWidget(viewModules[index]),
            ),
          );

          emit(
            state.copyWith(
              status: Status.success,
              tabId: tabId,
              currentPage: nextPage,
              viewModules: viewModuleList,
            ),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, error: error));
        },
      );
    } catch (e) {
      logging(e, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(e),
        ),
      );
    }
  }
}
