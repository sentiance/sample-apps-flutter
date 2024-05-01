import 'package:sentiance_event_timeline/sentiance_event_timeline.dart';

String formatGeoLocation(GeoLocation? location, {int fixed = 4}) {
  if (location == null) {
    return "Unknown";
  }

  return "${location.latitude?.toStringAsFixed(fixed)}, ${location.longitude?.toStringAsFixed(fixed)}";
}
