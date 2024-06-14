import 'package:e_commerce/domain/repository/display.repository.dart';
import 'package:e_commerce/domain/usecase/base/usecase.dart';
import 'package:injectable/injectable.dart';

@singleton
class DisplayUsecase {
  DisplayUsecase(this._displayRepository);

  final DisplayRepository _displayRepository;

  Future execute<T>({required Useecase usecase}) async {
    return await usecase.call(_displayRepository);
  }
}
