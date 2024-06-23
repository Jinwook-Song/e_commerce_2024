import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/model/display/display.model.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/domain/usecase/display/view_module/get_view_modules.usecase.dart';
import 'package:e_commerce/presentation/screens/home/fragments/view_module_list/factory/view_module_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'view_module_event.dart';
part 'view_module_state.dart';
part 'view_module_bloc.freezed.dart';

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

@injectable
class ViewModuleBloc extends Bloc<ViewModuleEvent, ViewModuleState> {
  final DisplayUsecase _displayUsecase;

  ViewModuleBloc(this._displayUsecase) : super(ViewModuleState()) {
    on<ViewModuleInitialized>(_onViewModuleInitialized);
    on<ViewModuleFetched>(
      _onViewModuleFetched,
      transformer: _throttleDroppable(const Duration(milliseconds: 400)),
    );
  }

  Future<Result<List<ViewModule>>> _fetch(
    int tabId, {
    int page = 1,
    required bool isRefresh,
  }) async {
    return await _displayUsecase.execute(
      usecase: GetViewModulesUsecase(
        tabId: tabId,
        page: page,
        isRefresh: isRefresh,
      ),
    );
  }

  Future<void> _onViewModuleInitialized(
    ViewModuleInitialized event,
    Emitter<ViewModuleState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final int tabId = event.tabId;

    emit(
      state.copyWith(
        status: Status.initial,
        currentPage: 1,
        isEndOfPage: false,
        viewModules: [],
      ),
    );

    try {
      final response = await _fetch(tabId, isRefresh: event.isRefresh);
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
      final response = await _fetch(tabId, page: nextPage, isRefresh: false);
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
