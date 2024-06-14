import 'package:e_commerce/domain/repository/repository.dart';

abstract class Useecase<T extends Repository> {
  Future call(T repository);
}
