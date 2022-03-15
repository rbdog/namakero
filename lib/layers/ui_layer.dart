import 'package:flutter/material.dart';

class UiLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: double.infinity,
      height: 80,
      child: Text('Tap to Start'),
    );
    final column = Column(
      children: [
        Spacer(),
        container,
      ],
    );
    return column;
  }
}
