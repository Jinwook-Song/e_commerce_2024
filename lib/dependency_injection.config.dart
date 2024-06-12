// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_commerce/data/data_source/data_source_module.dart' as _i10;
import 'package:e_commerce/data/data_source/remote/display.api.dart' as _i4;
import 'package:e_commerce/data/repository_impl/display_repository_impl.dart'
    as _i6;
import 'package:e_commerce/domain/repository/display.repository.dart' as _i5;
import 'package:e_commerce/domain/usecase/display/display.usecase.dart' as _i7;
import 'package:e_commerce/presentation/screens/home/bloc/menu_bloc/menu_bloc.dart'
    as _i8;
import 'package:e_commerce/presentation/screens/home/bloc/view_module_bloc/view_module_bloc.dart'
    as _i9;
import 'package:e_commerce/presentation/screens/main/bloc/cart_bloc/cart_bloc.dart'
    as _i3;
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
    gh.factory<_i3.CartBloc>(() => _i3.CartBloc());
    gh.singleton<_i4.DisplayApi>(() => dataSourceModule.displayApi);
    gh.singleton<_i5.DisplayRepository>(
        () => _i6.DisplayRepositoryImpl(gh<_i4.DisplayApi>()));
    gh.singleton<_i7.DisplayUsecase>(
        () => _i7.DisplayUsecase(gh<_i5.DisplayRepository>()));
    gh.factory<_i8.MenuBloc>(() => _i8.MenuBloc(gh<_i7.DisplayUsecase>()));
    gh.factory<_i9.ViewModuleBloc>(
        () => _i9.ViewModuleBloc(gh<_i7.DisplayUsecase>()));
    return this;
  }
}

class _$DataSourceModule extends _i10.DataSourceModule {}
