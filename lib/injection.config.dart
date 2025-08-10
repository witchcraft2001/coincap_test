// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coincap_testapp/data/data_sources/asset_data_source.dart'
    as _i697;
import 'package:coincap_testapp/data/repositories/asset_repository_impl.dart'
    as _i491;
import 'package:coincap_testapp/di/dio_module.dart' as _i573;
import 'package:coincap_testapp/domain/repositories/asset_repository.dart'
    as _i15;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i697.AssetDataSource>(
      () => _i697.AssetRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i15.AssetRepository>(
      () => _i491.AssetRepositoryImpl(gh<_i697.AssetDataSource>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i573.RegisterModule {}
