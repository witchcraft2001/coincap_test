import 'package:coincap_testapp/data/mappers/asset_dto_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../data_sources/asset_data_source.dart';

@LazySingleton(as: AssetRepository)
class AssetRepositoryImpl implements AssetRepository {
  final AssetDataSource _remote;

  AssetRepositoryImpl(this._remote);

  @override
  Future<List<Asset>> getAssets({required int limit, required int offset}) async {
    final list = await _remote.fetchAssets(limit: limit, offset: offset);
    return list.map((e) => e.toDomain()).toList(growable: false);
  }
}
