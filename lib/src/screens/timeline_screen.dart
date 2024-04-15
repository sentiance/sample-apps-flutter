import 'dart:math';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sentiance_user_context/sentiance_user_context.dart';
import 'package:sentiance_event_timeline/sentiance_event_timeline.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

// boilerplate for the simple stateful widget
class _TimelineScreenState extends State<TimelineScreen> {
  final sentianceUserContext = SentianceUserContext();
  final sentianceEventTimeline = SentianceEventTimeline();

  List<TimelineEvent?> events = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    final _events = await sentianceEventTimeline.getTimelineEvents(
        0, DateTime.now().millisecondsSinceEpoch);

    setState(() {
      events = _events.reversed.toList().take(30).toList();
    });
  }

  Widget _buildTimeline() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: events.map((item) {
          item!;

          final DateFormat outputFormat = DateFormat("MMM, dd. h:mm a");
          final localDate = DateTime.parse(item.startTime).toLocal();
          final String localTime = outputFormat.format(localDate);

          return Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  item!.type.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(localTime),
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
      body: SingleChildScrollView(
          child: events.isNotEmpty ? _buildTimeline() : emptyTimeline()),
    );
  }
}
