import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/base/local.usecase.dart';

class DeleteCartListUsecase extends LocalUsecase<DisplayRepository> {
  final List<String> productIds;
  DeleteCartListUsecase(this.productIds);

  @override
  Future call(DisplayRepository repository) async {
    final result =
        await repository.deleteCartByProductId(productIds: productIds);

    return result.status.isSuccess
        ? Result.success(result.data)
        : Result.failure(
            ErrorResponse(
              status: result.status,
              code: result.code,
              message: result.message,
            ),
          );
  }
}
