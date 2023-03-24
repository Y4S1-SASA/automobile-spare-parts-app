import 'package:automobile_spare_parts_app/data/models/item.model.dart';
import 'package:automobile_spare_parts_app/utils.dart';
import 'package:automobile_spare_parts_app/view/screens/item/item.edit.dart';
import 'package:automobile_spare_parts_app/view/screens/item/item.market.list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '/utils.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_database/firebase_database.dart';

class ItemView extends StatefulWidget {
  ItemView({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  DatabaseReference dbContext = FirebaseDatabase.instance.ref().child('items');
  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
        appBar: AppBar(
          title: Text('Items'),
          backgroundColor: const Color(0xff5db075),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 12 * fem,
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
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 21.79 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 12 * fem,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  33 * fem, 0 * fem, 182 * fem, 30 * fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 137.35 * fem, 0 * fem),
                                    width: 11.65 * fem,
                                    height: 26 * fem,
                                    child: Image.asset(
                                      'assets/page-1/images/icon-arrow-left-1.png',
                                      width: 11.65 * fem,
                                      height: 26 * fem,
                                    ),
                                  ),
                                  Text(
                                    'Item',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 1 * fem, 21 * fem),
                              child: Text(
                                widget.itemModel.name,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2125 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Container(
                              child: Image.network(widget.itemModel.imageUrl ??
                                  'https://picsum.photos/200/300'),
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 8 * fem),
                              width: 200 * fem,
                              height: 200 * fem,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8 * fem),
                                color: Color(0xfff6f6f6),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 133 * fem, 31 * fem),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 20 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2102272034 * ffem / fem,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Available Qty : ',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 20 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                          TextSpan(
                                            text: widget.itemModel.quantity
                                                .toString(),
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 20 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2125 * ffem / fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 20 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125 * ffem / fem,
                                        color: Color(0xff000000),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Unit Price : ',
                                        ),
                                        TextSpan(
                                          text: "LKR + " +
                                              widget.itemModel.price.toString(),
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 20 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  34 * fem, 0 * fem, 16 * fem, 60 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                    child: Text(
                                      'About',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 20 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.2125 * ffem / fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 395 * fem,
                                    ),
                                    child: Text(
                                      widget.itemModel.description.toString(),
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5 * ffem / fem,
                                        letterSpacing: 0.150000006 * fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xff5db075)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0)))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditItemScreen(
                                              itemModel: widget.itemModel)));
                                },
                                child: const Text(
                                  'Update Item',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 216, 57, 57)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0)))),
                                onPressed: () async {
                                  if (await confirm(context,
                                      title: const Text("Confirm"),
                                      content: const Text(
                                          "Are you sure you want to delete this item?"),
                                      textOK: const Text("Yes"),
                                      textCancel: const Text("No"))) {
                                    dbContext
                                        .child(widget.itemModel.id)
                                        .remove();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ItemMarketList()));
                                  }
                                },
                                child: const Text(
                                  'Delete Item',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
