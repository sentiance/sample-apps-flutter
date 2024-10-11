import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample_apps_flutter/src/helpers/utils.dart';
import 'package:sentiance_driving_insights/sentiance_driving_insights.dart';
import 'package:sentiance_event_timeline/sentiance_event_timeline.dart';
import 'package:sentiance_user_context/sentiance_user_context.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

// boilerplate for the simple stateful widget
class _TimelineScreenState extends State<TimelineScreen> {
  final sentianceUserContext = SentianceUserContext();
  final sentianceEventTimeline = SentianceEventTimeline();
  final sentianceDrivingInsights = SentianceDrivingInsights();

  List<TimelineEvent?> events = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    final _events = await sentianceEventTimeline.getTimelineEvents(0, DateTime.now().millisecondsSinceEpoch);

    setState(() {
      events = _events.reversed.toList().take(30).toList();
    });
  }

  String getEventDetails(TimelineEvent event) {
    final DateFormat outputFormat = DateFormat("MMM, dd. h:mm a");
    final localDate = DateTime.fromMicrosecondsSinceEpoch(event.startTimeMs).toLocal();
    final String localTime = outputFormat.format(localDate);

    sentianceDrivingInsights.getDrivingInsights(event.id).then((value) => {print("sentiance log: insights: $value")});

    List<String> details = [
      "Date: $localTime",
      "Duration (s): ${event.endTimeMs != null ? event.durationInSeconds : "-"}",
    ];

    if (event is StationaryEvent) {
      details.addAll([
        "Location: ${formatGeoLocation(event.location)}",
      ]);
    }

    if (event is TransportEvent) {
      details.addAll([
        "Mode: ${event.transportMode}",
        "Waypoints: ${event.waypoints.length}",
        "Distance (m): ${event.distance}",
      ]);
    }
    return details.join("\n");
  }

  Widget _buildTimeline() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: events.map((item) {
          item!;

          return Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  item.runtimeType.toString(),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(getEventDetails(item)),
              ),
              Divider(color: Colors.grey.shade300),
            ],
          );
        }).toList());
  }

  Widget emptyTimeline() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.access_time,
            size: 32.0,
          ),
          SizedBox(height: 24),
          Text(
            'Your timeline is empty. Take a trip ...',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
      ),
      body: SingleChildScrollView(child: events.isNotEmpty ? _buildTimeline() : emptyTimeline()),
    );
  }
}
