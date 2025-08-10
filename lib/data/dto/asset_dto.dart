class AssetDto {
  final String id;
  final String symbol;
  final String name;
  final String? priceUsd;

  AssetDto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.priceUsd,
  });

  factory AssetDto.fromJson(Map<String, dynamic> json) => AssetDto(
    id: json['id'] as String,
    symbol: json['symbol'] as String,
    name: json['name'] as String,
    priceUsd: json['priceUsd'] as String?,
  );
}