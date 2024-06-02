import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';

class GetViewModulesUsecase extends RemoteUsecase<DisplayRepository> {
  final int tabId;
  final int page;
  GetViewModulesUsecase({
    required this.tabId,
    required this.page,
  });

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.getViewModuleByTabId(
      tabId: tabId,
      page: page,
    );

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
