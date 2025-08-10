import 'package:injectable/injectable.dart';

import '../entities/asset.dart';
import '../repositories/asset_repository.dart';

@injectable
class GetAssetsPageUseCase {
  final AssetRepository _repository;

  GetAssetsPageUseCase(this._repository);

  Future<List<Asset>> call({required int limit, required int offset}) =>
      _repository.getAssets(limit: limit, offset: offset);
}
