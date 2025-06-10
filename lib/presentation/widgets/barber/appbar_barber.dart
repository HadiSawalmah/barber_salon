import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarBarber extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarBarber({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Without MaterialApp around the page, Flutter automatically tries to maintain the theme and structure, and adds some implicit additions to fill in the missing context. So we removed it.
      automaticallyImplyLeading: false,

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
          IconButton(
            onPressed: () {
              context.push('/AllNotificationBarber');
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
