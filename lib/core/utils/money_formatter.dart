import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class MoneyFormatter {
  static final _usd = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  String toUsdString(double? value) {
    if (value == null || value.isNaN || value.isInfinite) return '-';
    return _usd.format(value);
  }
}
