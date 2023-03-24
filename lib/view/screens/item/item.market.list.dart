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
  final List<ItemModel> listOfItems = [];
  @override
  void initState() {
    super.initState();
    getListOfMarketItemsAsync();
  }

  getListOfMarketItemsAsync() async {
    final snapshot = await FirebaseDatabase.instance.ref('items').get();

    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      ItemModel item = ItemModel(
          id: value["id"],
          name: value["name"],
          category: value["category"],
          quantity: value["quantity"],
          price: 3,
          description: value["description"] ?? "",
          imageUrl: value["imageUrl"] ?? "",
          createdBy: value["createdBy"] ?? "");
      setState(() {
        listOfItems.add(item);
      });
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
              height: 12 * fem,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SaveItem()));
              },
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 34 * fem),
                width: double.infinity,
                child: Text(
                  'Add',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.2125 * ffem / fem,
                    color: Color.fromARGB(255, 6, 84, 79),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 235, 235, 235),
                hintText: 'Search Item',
                enabled: true,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 14.0),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Color.fromARGB(255, 217, 217, 217)),
                  borderRadius: new BorderRadius.circular(8),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      new BorderSide(color: Color.fromARGB(255, 217, 217, 217)),
                  borderRadius: new BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value!.length == 0) {
                  return "Quantity is Required";
                } else {
                  return null;
                }
              },
              onChanged: (value) {},
              keyboardType: TextInputType.name,
            ),
            Container(
              width: double.infinity,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffececec)),
                  color: Color(0xffffffff),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 1 * fem, 0 * fem),
                      width: double.infinity,
                      height: 1072 * fem,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 21 * fem,
                            top: 0 * fem,
                            child: Container(
                              width: 403 * fem,
                              height: 1072 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: listOfItems
                                    .map((item) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ItemView(
                                                          itemModel: item)));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              25 * fem, 0 * fem, 0 * fem),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Image.network(
                                                    item.imageUrl),
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem),
                                                width: double.infinity,
                                                height: 240 * fem,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8 * fem),
                                                  color: Color(0xfff6f6f6),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    7 * fem),
                                                child: Text(
                                                  item.name,
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 16 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2125 * ffem / fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              8 * fem),
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: 404 * fem,
                                                      ),
                                                      child: Text(
                                                        item.description,
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 14 * ffem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.2125 *
                                                              ffem /
                                                              fem,
                                                          color:
                                                              Color(0xff000000),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
