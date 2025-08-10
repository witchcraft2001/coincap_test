import '../../domain/entities/asset.dart';
import '../dto/asset_dto.dart';

extension AssetDtoMapper on AssetDto {
  Asset toDomain() =>
      Asset(id: id, symbol: symbol, name: name, priceUsd: priceUsd == null ? null : double.tryParse(priceUsd!));
}
