import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce/domain/usecase/display/menu/get_menus.usecase.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_event.dart';

part 'menu_state.dart';

part 'menu_bloc.freezed.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final DisplayUsecase _displayUsecase;

  MenuBloc(this._displayUsecase) : super(MenuState()) {
    on<MenuInitialized>(_onMenuInitialized);
  }

  Future<void> _onMenuInitialized(
    MenuInitialized event,
    Emitter<MenuState> emit,
  ) async {
    final mallType = event.mallType;

    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _fetch(mallType);
      response.when(
        success: (menus) {
          emit(
            state.copyWith(
              status: Status.success,
              mallType: mallType,
              menus: menus,
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

  Future<Result<List<Menu>>> _fetch(MallType mallType) async {
    return await _displayUsecase.execute(usecase: GetMenusUsecase(mallType));
  }
}
