import 'package:injectable/injectable.dart';

@injectable
class ColorGenerator {
  int symbolToColor(String key, {double whiteness = 0.7}) {
    final hash = key.hashCode;
    final r = (hash) & 0xFF;
    final g = (hash >> 8) & 0xFF;
    final b = (hash >> 16) & 0xFF;

    int mix(int c) => (c + ((255 - c) * whiteness)).round().clamp(0, 255);

    final pr = mix(r);
    final pg = mix(g);
    final pb = mix(b);

    return (0xFF << 24) | (pr << 16) | (pg << 8) | pb;
  }
}
