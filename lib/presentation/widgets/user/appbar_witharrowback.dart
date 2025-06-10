import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarWitharrowback extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const AppbarWitharrowback({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //Without MaterialApp around the page, Flutter automatically tries to maintain the theme and structure, and adds some implicit additions to fill in the missing context.So we removed it.
      automaticallyImplyLeading: false,

      backgroundColor: Color(0x90D6D4CA),
      title: Row(
        children: [
          Container(
            height: 40,
            width: 41,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 3)],
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 24)),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(color: Colors.red, height: 2.0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
