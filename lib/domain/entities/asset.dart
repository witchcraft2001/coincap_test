class Asset {
  final String id;
  final String symbol;
  final String name;
  final double? priceUsd;

  const Asset({
    required this.id,
    required this.symbol,
    required this.name,
    required this.priceUsd,
  });
}
