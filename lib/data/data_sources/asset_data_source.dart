import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../dto/asset_dto.dart';

abstract class AssetDataSource {
  Future<List<AssetDto>> fetchAssets({required int limit, required int offset});
}

@LazySingleton(as: AssetDataSource)
class AssetRemoteDataSourceImpl implements AssetDataSource {
  final Dio _dio;
  AssetRemoteDataSourceImpl(this._dio);

  @override
  Future<List<AssetDto>> fetchAssets({required int limit, required int offset}) async {
    final response = await _dio.get(
      '/v3/assets',
      queryParameters: {
        'limit': limit,
        'offset': offset,
      },
    );

    final data = response.data is Map<String, dynamic>
        ? (response.data['data'] as List<dynamic>?) ?? const []
        : const [];

    return data
        .whereType<Map<String, dynamic>>()
        .map(AssetDto.fromJson)
        .toList(growable: false);
  }
}
