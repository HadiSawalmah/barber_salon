import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class AppBarAdmin extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarAdmin({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 89,
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 22, bottom: 25),
        child: Container(
          height: 20,
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
                // context.pop();
              },
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(89);
}
