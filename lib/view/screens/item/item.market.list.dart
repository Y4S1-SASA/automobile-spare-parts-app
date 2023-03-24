import 'dart:ffi';
import 'package:automobile_spare_parts_app/data/models/item.model.dart';
import 'package:automobile_spare_parts_app/view/screens/item/item.view.dart';
import 'package:automobile_spare_parts_app/view/screens/item/save.item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemMarketList extends StatefulWidget {
  @override
  State<ItemMarketList> createState() => _ItemMarketListState();
}

class _ItemMarketListState extends State<ItemMarketList> {
  final DatabaseReference dbContextRef =
      FirebaseDatabase.instance.reference().child('items');
  String? currentUserEmail = FirebaseAuth.instance.currentUser!.email;

  // init items
  List<Map<dynamic, dynamic>> liftOfItems = [];
  // init filtered items
  List<Map<dynamic, dynamic>> listOfFilteredItems = [];
  @override
  void initState() {
    super.initState();
    getListOfMarketItemsAsync();
  }

  getListOfMarketItemsAsync() async {
    // get items of the logged user
    dbContextRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic>? map =
            event.snapshot.value as Map<dynamic, dynamic>?;
        // check if not null
        if (map != null) {
          map.forEach((key, value) {
            // map func
            final item =
                Map<dynamic, dynamic>.from(value as Map<dynamic, dynamic>);
            liftOfItems.add(item);
          });
          // set filtered state
          setState(() {
            listOfFilteredItems = liftOfItems;
          });
        }
      }
    });
  }

  void onSearchFilterChanged(String filter) {
    setState(() {
      listOfFilteredItems = liftOfItems
          .where((item) =>
              item['name'].toLowerCase().contains(filter.toLowerCase()) ||
              item['category'].toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
          title: Text('Items'),
          backgroundColor: const Color.fromARGB(255, 6, 84, 79),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 20 * fem,
            ),
            if (currentUserEmail == "admin@gmail.com")
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SaveItem()));
                },
                child: Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 34 * fem),
                  width: double.infinity,
                  child: currentUserEmail == "admin@gmail.com"
                      ? Text(
                          'Add',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2125 * ffem / fem,
                            color: Color.fromARGB(255, 6, 84, 79),
                          ),
                        )
                      : null,
                ),
              ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 235, 235, 235),
                  hintText: 'Search Item',
                  enabled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(8),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(
                        color: Color.fromARGB(255, 217, 217, 217)),
                    borderRadius: new BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  onSearchFilterChanged(value);
                },
                keyboardType: TextInputType.name,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8.0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: listOfFilteredItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = listOfFilteredItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
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
                      child: currentUserEmail == "admin@gmail.com"
                          ? const Icon(
                              Icons.view_stream_rounded,
                              color: Color.fromARGB(255, 6, 84, 79),
                            )
                          : const Icon(
                              Icons.shopping_cart_rounded,
                              color: Color.fromARGB(255, 6, 84, 79),
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
        )));
  }
}
