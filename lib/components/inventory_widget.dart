import 'package:flutter/material.dart';

import '../helpers/responsive.dart';

class InventoryWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Color borderColor;
  final VoidCallback onPress;

  InventoryWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPress, required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onPress,
        child: Container(

          height: ResponsiveWidget.isLargeScreen(context) ?  200 : 150,
          width: ResponsiveWidget.isLargeScreen(context) ? 600 : 450,decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Vertically center children
              children: [
                Icon(icon, size: 100, color: Colors.green), // Adjust size as needed
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
