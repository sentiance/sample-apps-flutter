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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.access_time,
              size: 32.0,
            ),
            SizedBox(height: 24),
            Text(
              'On device timeline coming soon...',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
