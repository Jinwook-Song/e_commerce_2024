import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:e_commerce/core/utils/extensions.dart';
import 'package:e_commerce/domain/model/common/result.dart';
import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/base/local.usecase.dart';

class ChangeCartQtyUsecase extends LocalUsecase<DisplayRepository> {
  final String productId;
  final int quantity;
  ChangeCartQtyUsecase(this.productId, this.quantity);

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.changeCartQuantityByProductId(
      productId: productId,
      quantity: quantity,
    );

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
