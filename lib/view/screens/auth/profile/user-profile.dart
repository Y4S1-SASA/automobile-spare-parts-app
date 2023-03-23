import 'package:automobile_spare_parts_app/view/screens/auth/profile/edit-user-profile.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user!.imageUrl),
            ),
            SizedBox(height: 20),
            Text(
              (user?.firstName ?? '') + ' ' + (user?.lastName ?? ''),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              user?.email ?? '',
              style: TextStyle(fontSize: 16),
            ),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => EditProfileScreen()),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    userProvider.deleteUser(context);

                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
