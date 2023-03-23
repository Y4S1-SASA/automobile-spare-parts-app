import 'package:automobile_spare_parts_app/view/screens/auth/profile/edit-user-profile.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    final user = userProvider.user;
final DatabaseReference _itemsRef = FirebaseDatabase.instance.reference().child('items');
final String userEmail = userProvider.user?.email ?? '';


    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: user?.imageUrl == null
                  ? AssetImage(
                      'assets/users/profile-icon.png',
                      // width: 120,
                      // height: 120,
                    ) as ImageProvider<Object>?
                  : NetworkImage(user!.imageUrl) as ImageProvider<Object>?,
            ),
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: NetworkImage(user!.imageUrl),
            // ),
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
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    userProvider.logout(context);
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
