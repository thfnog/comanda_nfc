import 'package:flutter/material.dart';

import '../../const/color_constants.dart';

class CustomControlButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isEnabled;
  final Function() onTap;

  const CustomControlButton({super.key, required this.title, required this.iconData, this.isEnabled = true, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) =>
          ColorConstants.primaryColor
        ),
      ),
      icon: Icon(
        color: Colors.white,
        iconData,
        size: 24.0,
      ),
      label: Text(
          title,
          style: const TextStyle(color: Colors.white)
      ),
    );
  }
}
