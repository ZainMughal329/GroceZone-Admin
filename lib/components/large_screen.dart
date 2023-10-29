import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey.withOpacity(0.2),),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.grey.withOpacity(0.4),),
        ),
      ],
    );
  }
}
