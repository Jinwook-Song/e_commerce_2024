import 'package:e_commerce/domain/repository/repository.dart';

abstract class RemoteUsecase<T extends Repository> {
  Future call(T repository);
}
