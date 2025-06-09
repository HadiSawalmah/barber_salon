import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_new/presentation/widgets/admin/appbar_admin.dart';

import '../../../data/models/user/user_model.dart';
import '../../../providers/admin/users_acount_provider.dart';
import '../../widgets/admin/drawer_admin.dart';

class UsersAccount extends StatefulWidget {
  const UsersAccount({super.key});

  @override
  State<UsersAccount> createState() => _UsersAccountState();
}

class _UsersAccountState extends State<UsersAccount> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<UsersAcountProvider>(context, listen: false).fetchUsers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
        backgroundColor: Colors.grey[300],
      ),
      drawer: DrawerAdmin(),
      body: Consumer<UsersAcountProvider>(
        builder: (context, provider, child) {
          final users = provider.users;

          if (users.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final UserModel user = users[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                color: const Color.fromARGB(221, 220, 216, 216),

                child: ListTile(
                  title: Text(user.name, style: TextStyle(color: Colors.black)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email, style: TextStyle(color: Colors.black)),
                      Text(user.phone, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await provider.deleteUser(user.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'This user has been successfully deleted',
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
