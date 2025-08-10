import '../entities/asset.dart';

abstract class AssetRepository {
  Future<List<Asset>> getAssets({required int limit, required int offset});
}
