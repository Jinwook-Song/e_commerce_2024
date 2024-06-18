import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/exception/common_exception.dart';
import 'package:e_commerce/core/utils/logging.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/usecase/user/login.usecase.dart';
import 'package:e_commerce/domain/usecase/user/login_w_token.usecase.dart';
import 'package:e_commerce/domain/usecase/user/logout.usecase.dart';
import 'package:e_commerce/domain/usecase/user/user.usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

part 'user_event.dart';

part 'user_state.dart';

part 'user_bloc.freezed.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecase _userUsecase;

  UserBloc(this._userUsecase) : super(UserState()) {
    on<UserLogin>(_onUserLogin);
    on<UserLoginWithToken>(_onUserLoginWithToken);
    on<UserLogout>(_onUserLogout);
  }

  Future<void> _onUserLogin(
    UserLogin event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await _userUsecase.execute<Result<User>>(
        usecase: LoginUsecase(),
      );

      response.when(
        success: (user) {
          emit(state.copyWith(status: Status.success, user: user));
        },
        failure: (_) {
          emit(state.copyWith(status: Status.initial));
        },
      );
    } on ErrorResponse catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          error: error,
        ),
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<void> _onUserLoginWithToken(
    UserLoginWithToken event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await _userUsecase.execute<Result<User>>(
        usecase: LoginWithTokenUsecase(),
      );

      response.when(
        success: (user) {
          emit(state.copyWith(status: Status.success, user: user));
        },
        failure: (_) {
          emit(state.copyWith(status: Status.initial));
        },
      );
    } on ErrorResponse catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          error: error,
        ),
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }

  Future<void> _onUserLogout(
    UserLogout event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _userUsecase.execute(usecase: LogoutUsecase());
      emit(state.copyWith(status: Status.initial, user: null));
    } on ErrorResponse catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          error: error,
        ),
      );
    } catch (error) {
      logging(error, logType: LogType.error);
      emit(
        state.copyWith(
          status: Status.error,
          error: CommonException.setError(error),
        ),
      );
    }
  }
}
