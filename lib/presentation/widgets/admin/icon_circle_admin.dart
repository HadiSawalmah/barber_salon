import 'package:flutter/material.dart';

class IconCircleAdmin extends StatelessWidget {
  const IconCircleAdmin({super.key, required this.icon, required this.onpress});
  final Icon icon;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onpress, icon: icon);
  }
}
