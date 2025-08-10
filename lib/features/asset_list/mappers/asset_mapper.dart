import 'package:coincap_testapp/core/utils/money_formatter.dart';
import 'package:injectable/injectable.dart';

import '../../../core/utils/color_generator.dart';
import '../../../domain/entities/asset.dart';
import '../presentation/bloc/asset_item_view_state.dart';

@injectable
class AssetMapper {
  final MoneyFormatter _moneyFormatter;
  final ColorGenerator _colorGenerator;

  AssetMapper(this._moneyFormatter, this._colorGenerator);

  AssetItemViewState toViewState(Asset asset) {
    return AssetItemViewState(
      id: asset.id,
      symbol: asset.symbol,
      price: _moneyFormatter.toUsdString(asset.priceUsd),
      color: _colorGenerator.symbolToColor(asset.symbol),
    );
  }
}
