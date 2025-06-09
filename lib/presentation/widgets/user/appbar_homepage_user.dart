import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../providers/user/user_provider.dart';

class AppbarHomepageUser extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarHomepageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0x90D6D4CA),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              context.push('/CustomerNotificationsPage');
            },
            icon: Icon(Icons.notifications_none, size: 35, color: Colors.white),
          ),
          Consumer<UserProvider>(
            builder: (context, prov, child) {
              final username = prov.user?.name ?? 'welcome';
              return Text(
                username,
                style: TextStyle(color: Colors.white, fontSize: 24),
              );
            },
          ),
          IconButton(
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder:
                    (ctx) => AlertDialog(
                      title: Text('Confirm Delete '),
                      content: Text('Are you sure you want to log out ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: Text(
                            'Log Out ',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
              );

              if (shouldLogout == true) {
                FirebaseAuth.instance.signOut();
                context.go('/Loginuser');
              }
            },

            icon: Icon(Icons.logout, size: 30, color: Colors.white),
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
