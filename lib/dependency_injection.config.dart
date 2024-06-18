// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_commerce/data/data_source/data_source_module.dart' as _i18;
import 'package:e_commerce/data/data_source/local/display.dao.dart' as _i7;
import 'package:e_commerce/data/data_source/remote/display/display.api.dart'
    as _i5;
import 'package:e_commerce/data/data_source/remote/user/user.api.dart' as _i6;
import 'package:e_commerce/data/repository_impl/display.repository_impl.dart'
    as _i9;
import 'package:e_commerce/data/repository_impl/user.repository_impl.dart'
    as _i11;
import 'package:e_commerce/domain/repository/display.repository.dart' as _i8;
import 'package:e_commerce/domain/repository/user.repository.dart' as _i10;
import 'package:e_commerce/domain/usecase/display/display.usecase.dart' as _i12;
import 'package:e_commerce/domain/usecase/user/user.usecase.dart' as _i13;
import 'package:e_commerce/presentation/screens/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart'
    as _i16;
import 'package:e_commerce/presentation/screens/home/bloc/menu_bloc/menu_bloc.dart'
    as _i14;
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart'
    as _i15;
import 'package:e_commerce/presentation/screens/main/bloc/cart_bloc/cart_bloc.dart'
    as _i4;
import 'package:e_commerce/presentation/screens/main/bloc/paymoent_bloc/payment_bloc.dart'
    as _i3;
import 'package:e_commerce/presentation/screens/main/bloc/user_bloc/user_bloc.dart'
    as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dataSourceModule = _$DataSourceModule();
    gh.factory<_i3.PaymentBloc>(() => _i3.PaymentBloc());
    gh.factory<_i4.CartBloc>(() => _i4.CartBloc());
    gh.singleton<_i5.DisplayApi>(() => dataSourceModule.displayApi);
    gh.singleton<_i6.UserApi>(() => dataSourceModule.userApi);
    gh.singleton<_i7.DisplayDao>(() => dataSourceModule.displayDao);
    gh.singleton<_i8.DisplayRepository>(() => _i9.DisplayRepositoryImpl(
          gh<_i5.DisplayApi>(),
          gh<_i7.DisplayDao>(),
        ));
    gh.singleton<_i10.UserRepository>(
        () => _i11.UserRepositoryImpl(gh<_i6.UserApi>()));
    gh.singleton<_i12.DisplayUsecase>(
        () => _i12.DisplayUsecase(gh<_i8.DisplayRepository>()));
    gh.singleton<_i13.UserUsecase>(
        () => _i13.UserUsecase(gh<_i10.UserRepository>()));
    gh.factory<_i14.MenuBloc>(() => _i14.MenuBloc(gh<_i12.DisplayUsecase>()));
    gh.factory<_i15.ViewModuleBloc>(
        () => _i15.ViewModuleBloc(gh<_i12.DisplayUsecase>()));
    gh.factory<_i16.CartListBloc>(
        () => _i16.CartListBloc(gh<_i12.DisplayUsecase>()));
    gh.factory<_i17.UserBloc>(() => _i17.UserBloc(gh<_i13.UserUsecase>()));
    return this;
  }
}

class _$DataSourceModule extends _i18.DataSourceModule {}
