import 'package:flutter/material.dart';

class AppbarBarber extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarBarber({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0x90D6D4CA),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 24)),
            ],
          ),
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
