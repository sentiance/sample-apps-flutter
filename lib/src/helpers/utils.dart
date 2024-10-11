import 'package:sentiance_core/sentiance_core.dart' show GeoLocation;

String formatGeoLocation(GeoLocation? location, {int fixed = 4}) {
  if (location == null) {
    return "Unknown";
  }

  return "${location.latitude?.toStringAsFixed(fixed)}, ${location.longitude?.toStringAsFixed(fixed)}";
}
