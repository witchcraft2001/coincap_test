// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coincap_testapp/core/utils/color_generator.dart' as _i266;
import 'package:coincap_testapp/core/utils/money_formatter.dart' as _i843;
import 'package:coincap_testapp/data/data_sources/asset_data_source.dart'
    as _i697;
import 'package:coincap_testapp/data/repositories/asset_repository_impl.dart'
    as _i491;
import 'package:coincap_testapp/di/dio_module.dart' as _i573;
import 'package:coincap_testapp/domain/repositories/asset_repository.dart'
    as _i15;
import 'package:coincap_testapp/domain/usecases/get_assets_page_use_case.dart'
    as _i717;
import 'package:coincap_testapp/features/asset_list/mappers/asset_mapper.dart'
    as _i748;
import 'package:coincap_testapp/features/asset_list/presentation/bloc/asset_list_bloc.dart'
    as _i39;
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
    gh.factory<_i843.MoneyFormatter>(() => _i843.MoneyFormatter());
    gh.factory<_i266.ColorGenerator>(() => _i266.ColorGenerator());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i697.AssetDataSource>(
      () => _i697.AssetRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i748.AssetMapper>(
      () => _i748.AssetMapper(
        gh<_i843.MoneyFormatter>(),
        gh<_i266.ColorGenerator>(),
      ),
    );
    gh.lazySingleton<_i15.AssetRepository>(
      () => _i491.AssetRepositoryImpl(gh<_i697.AssetDataSource>()),
    );
    gh.factory<_i717.GetAssetsPageUseCase>(
      () => _i717.GetAssetsPageUseCase(gh<_i15.AssetRepository>()),
    );
    gh.factory<_i39.AssetListBloc>(
      () => _i39.AssetListBloc(
        gh<_i717.GetAssetsPageUseCase>(),
        gh<_i748.AssetMapper>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i573.RegisterModule {}
