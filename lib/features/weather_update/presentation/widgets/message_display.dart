import 'package:weatherapp/core/util/fonts_and_padding.dart';
import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
            message,
            style: TextStyle(fontSize: fontH2(context),
            color: Colors.red),
            textAlign: TextAlign.center,
          ),
      ),
    );
  }
}
