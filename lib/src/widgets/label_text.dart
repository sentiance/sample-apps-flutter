import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String label;
  final String text;

  LabelText({required Key key, required this.label, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(text),
      ],
    );
  }
}
