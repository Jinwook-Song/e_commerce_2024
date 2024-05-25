import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/base/remote.usecase.dart';

class DisplayUsecase {
  DisplayUsecase(this._displayRepository);

  final DisplayRepository _displayRepository;

  Future execute<T>({required RemoteUsecase usecase}) async {
    return await usecase.call(_displayRepository);
  }
}
