import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarUser extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarUser({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0x90D6D4CA),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 24)),
            ],
          ),
        ],
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(color: Colors.red, height: 2.0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
