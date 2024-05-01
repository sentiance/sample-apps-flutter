import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const logsPath = 's_logs.txt';

final DateFormat outputFormat = DateFormat("MMM, dd. h:mm:ss a");

Future<void> writeLog(String data) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/$logsPath');
  final localDate =
      DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch)
          .toLocal();

  final String localTime = outputFormat.format(localDate);

  file.writeAsString("${localTime}: $data\n", mode: FileMode.append);
}

Future<void> writeFile(String data) async {
  return writeLog(data);
}

Future<List<String>> getLogs() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$logsPath');
    String fileContents = await file.readAsString();

    List<String> logs = fileContents.split("\n").reversed.toList();
    return logs.where((log) => log.trim().isNotEmpty).take(50).toList();
  } catch (e) {
    print("Failed to log file: $e");
    return [];
  }
}

Future<void> requestFilePermissions() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
