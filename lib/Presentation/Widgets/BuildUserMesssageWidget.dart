import 'package:flutter/material.dart';

class UserMessageWidget extends StatelessWidget {
  final String message;

  const UserMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(message.trimLeft()),
      ),
    );
  }
}
