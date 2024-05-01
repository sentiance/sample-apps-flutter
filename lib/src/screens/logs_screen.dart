import 'package:flutter/material.dart';
import 'package:sample_apps_flutter/src/helpers/log.dart';

class LogsScreen extends StatefulWidget {
  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  List<String> logs = [];

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    final logs = await getLogs();
    setState(() {
      this.logs = logs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logs'),
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  logs[index],
                  style: TextStyle(fontSize: 14.0), // Smaller font size
                ),
              ),
              Divider(color: Colors.grey.shade300),
            ],
          );
        },
      ),
    );
  }
}
