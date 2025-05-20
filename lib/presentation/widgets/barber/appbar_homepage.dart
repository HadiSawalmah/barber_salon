import 'package:flutter/material.dart';

class AppbarHomepage extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarHomepage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0x90D6D4CA),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 24)),
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.notifications_none, size: 35, color: Colors.white),
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
