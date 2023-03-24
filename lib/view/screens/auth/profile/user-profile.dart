import 'package:automobile_spare_parts_app/data/models/item.model.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/profile/edit-user-profile.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/auth_provider.dart';
import 'package:automobile_spare_parts_app/view/screens/item/item.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automobile_spare_parts_app/view/screens/auth/provider/user.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

// profile screen state
class _ProfileScreenState extends State<ProfileScreen> {
  // instance for items
  final DatabaseReference _itemsRef =
      FirebaseDatabase.instance.reference().child('items');

  // init items
  List<Map<dynamic, dynamic>> _items = [];
  // init filtered items
  List<Map<dynamic, dynamic>> _filteredItems = [];

  // search controller
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // get auth data
    final userProvider = Provider.of<AuthProvider>(context, listen: false);
    final userEmail = userProvider.user?.email ?? '';

    // get items of the logged user
    _itemsRef
        .orderByChild('createdBy')
        .equalTo(userEmail)
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic>? map =
            event.snapshot.value as Map<dynamic, dynamic>?;
        // check if not null
        if (map != null) {
          map.forEach((key, value) {
            // map func
            final item =
                Map<dynamic, dynamic>.from(value as Map<dynamic, dynamic>);
            _items.add(item);
          });
          // set filtered state
          setState(() {
            _filteredItems = _items;
          });
        }
      }
    });
  }

  void _filterItems(String query) {
    // filter state for items
    setState(() {
      _filteredItems = _items
          .where((item) =>
              // filter by name
              item['name'].toLowerCase().contains(query.toLowerCase()) ||
              // filter by category
              item['category'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // auth provider
    final userProvider = Provider.of<AuthProvider>(context);
    final user = userProvider.user;
    // item modal
    final List<ItemModel> listOfItems = [];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // profile section starts  here
            Container(
              color: Color.fromARGB(255, 6, 84, 79),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  // Text(
                  //         "Profile",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w400,
                  //           color: Color.fromARGB(255, 255, 255, 255),
                  //           fontSize: 24,
                  //           fontFamily: "Inter",
                  //         ),
                  //       ),
                  SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user?.imageUrl == null
                        ? AssetImage(
                            'assets/users/profile-icon.png',
                          ) as ImageProvider<Object>?
                        : NetworkImage(user!.imageUrl)
                            as ImageProvider<Object>?,
                  ),
                  SizedBox(height: 20),
                  // user first name and last name
                  Text(
                    (user?.firstName ?? '') + ' ' + (user?.lastName ?? ''),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                  SizedBox(height: 10),

                  // user email
                  Text(
                    user?.email ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),

                  SizedBox(height: 20),

                  // icon set displays here
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: IconButton(
                          // navigate to edit profile
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => EditProfileScreen()),
                            );
                          },
                          icon: Icon(Icons.edit),
                          color: Color.fromARGB(255, 6, 84, 79),
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: IconButton(
                          // trigger delete user in provider
                          onPressed: () {
                            userProvider.deleteUser(context);
                          },
                          icon: Icon(Icons.delete),
                          color: Color.fromARGB(255, 6, 84, 79),
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        child: IconButton(
                          // trigger logout inprovider
                          onPressed: () {
                            userProvider.logout(context);
                          },
                          icon: Icon(Icons.logout),
                          color: Color.fromARGB(255, 6, 84, 79),
                        ),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // items section starts here
            Container(
              alignment: Alignment.center,
              child: Text(
                "My Items",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 6, 84, 79),
                  fontSize: 24,
                  fontFamily: "Inter",
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // search bos
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 244, 243, 243),
                  hintText: 'Search Items by name',
                  enabled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(150),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(8),
                  ),
                ),
                onChanged: (query) {
                  _filterItems(query);
                },
              ),
            ),

            // List view
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: _filteredItems.length,
              itemBuilder: (BuildContext context, int index) {
                // filtered data
                final item = _filteredItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // item data to be displayed
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    leading: item['imageUrl'] != null
                        ? Image.network(
                            item['imageUrl'] as String,
                            width: 50,
                            height: 50,
                          )
                        : SizedBox.shrink(),
                    title: Text(
                      item['name'] as String? ?? '',
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      item['category'] as String? ?? '',
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: MaterialButton(
                      child: Text(
                        'View',
                        style: TextStyle(
                          color: Color.fromARGB(255, 6, 84, 79),
                        ),
                      ),
                      onPressed: () {
                        // navigate to item detail
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemView(
                              itemModel: ItemModel(
                                id: item["id"],
                                name: item["name"],
                                category: item["category"],
                                quantity: item["quantity"],
                                price: 3,
                                description: item["description"] ?? "",
                                imageUrl: item["imageUrl"] ?? "",
                                createdBy: item["createdBy"] ?? "",
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
