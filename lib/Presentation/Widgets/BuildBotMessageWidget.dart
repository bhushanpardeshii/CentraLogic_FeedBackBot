import 'package:flutter/material.dart';

class BotMessageWidget extends StatelessWidget {
  final String message;

  const BotMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/img.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(message, overflow: TextOverflow.visible),
            ),
          ],
        ),
      ),
    );
  }
}
