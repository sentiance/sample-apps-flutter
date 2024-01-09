import 'package:flutter/material.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

// boilerplate for the simple stateful widget
class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
      ),
      body: const Center(
        child: Text(
          'Timeline Content',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
