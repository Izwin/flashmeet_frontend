import 'package:flutter/material.dart';

class DefaultModalBottomSheet extends StatelessWidget {
  final List<Widget> elements;

  DefaultModalBottomSheet({required this.elements});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: elements,
      ),
    );
  }
}
