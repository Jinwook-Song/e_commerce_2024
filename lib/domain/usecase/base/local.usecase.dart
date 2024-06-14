import 'package:e_commerce/domain/repository/repository.dart';
import 'package:e_commerce/domain/usecase/base/usecase.dart';

abstract class LocalUsecase<T extends Repository> extends Useecase<T> {}
