import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';
import 'package:e_commerce/presentation/screens/main/cubit/mall_type_cubit.dart';

class GetMenusUsecase extends RemoteUsecase<DisplayRepository> {
  GetMenusUsecase(this.mallType);

  final MallType mallType;

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.getMenusByMallType(mallType: mallType);

    return result.status == 'SUCCESS'
        ? Result.success(result.data ?? [])
        : Result.failure(
            ErrorResponse(
              status: result.status,
              code: result.code,
              message: result.message,
            ),
          );
  }
}
