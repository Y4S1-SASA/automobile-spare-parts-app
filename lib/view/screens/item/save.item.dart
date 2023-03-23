import 'dart:io';

import 'package:automobile_spare_parts_app/data/models/item.model.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-create.dart';
import 'package:automobile_spare_parts_app/view/screens/reservations/place-order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SaveItem extends StatefulWidget {
  SaveItem({super.key});
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final quantityController = TextEditingController();
  final unitPriceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  State<SaveItem> createState() => _SaveItemState();
}

class _SaveItemState extends State<SaveItem> {
  int _selectedAppBarIconIndex = 1;

  void _appBarIconTap(int index) {
    setState(() {
      _selectedAppBarIconIndex = index;
    });
  }

  late File? image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
  }

  String selectedCategory = 'Item 1';
  final List<String> ctegories = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            const Text(
              "Create Shop Item",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 24,
                fontFamily: "Inter",
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Center(
              child: Stack(children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(width: 4, color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 10))
                    ],
                  ),
                )
              ]),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox(height: 2),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63),
                          fontSize: 12,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    TextFormField(
                      controller: widget.nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 235, 235),
                        hintText: 'Enter Name of the item',
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
                      validator: (value) {
                        if (value!.length == 0) {
                          return "Last Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        "Category",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63),
                          fontSize: 12,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 235, 235, 235),
                        border: Border.all(
                            color: const Color.fromARGB(255, 217, 217, 217)),
                      ),
                      child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          icon: const Icon(Icons.arrow_drop_down),
                          alignment: Alignment.centerRight,
                          iconSize: 36,
                          underline: const SizedBox(),
                          hint: Text(selectedCategory),
                          value: selectedCategory,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue.toString();
                            });
                          },
                          items: ctegories.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                              ),
                            );
                          }).toList()),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: const Text(
                                    "Quantity",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 63, 63, 63),
                                      fontSize: 12,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                TextFormField(
                                  controller: widget.quantityController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    hintText: 'Enter Quantity',
                                    enabled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 14.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 217, 217, 217)),
                                      borderRadius:
                                          new BorderRadius.circular(8),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 217, 217, 217)),
                                      borderRadius:
                                          new BorderRadius.circular(8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.length == 0) {
                                      return "Last Name cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.name,
                                ),
                              ],
                            )),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: const Text(
                                    "Unit Price(LKR)",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color.fromARGB(255, 63, 63, 63),
                                      fontSize: 12,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                TextFormField(
                                  controller: widget.unitPriceController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    hintText: 'Enter Price',
                                    enabled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 14.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 217, 217, 217)),
                                      borderRadius:
                                          new BorderRadius.circular(8),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color.fromARGB(
                                              255, 217, 217, 217)),
                                      borderRadius:
                                          new BorderRadius.circular(8),
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
                              ],
                            )),
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: const Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 63, 63, 63),
                          fontSize: 12,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    TextFormField(
                      controller: widget.descriptionController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 235, 235, 235),
                        hintText: 'Enter Description for the item',
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
                      validator: (value) {
                        if (value!.length == 0) {
                          return "Last Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {},
                      keyboardType: TextInputType.name,
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
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff5db075)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ItemModel itemModel = ItemModel(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                name: widget.nameController.text,
                                category: selectedCategory,
                                quantity:
                                    int.parse(widget.quantityController.text),
                                price: double.parse(
                                    widget.unitPriceController.text),
                                description: widget.descriptionController.text);

                            saveItem(itemModel);
                          }
                        },
                        child: const Text(
                          'Create Item',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 130,
                    ),
                  ]),
                )),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   color: Color(0xff5db075),
      //   height: 60,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 0
      //             ? Image.asset('assets/appbar/article_filled.png')
      //             : Image.asset('assets/appbar/article.png'),
      //         onPressed: () {
      //           _appBarIconTap(0);
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => Scene()),
      //           );
      //         },
      //       ),
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 1
      //             ? Image.asset('assets/appbar/market_filled.png')
      //             : Image.asset('assets/appbar/market.png'),
      //         onPressed: () => _appBarIconTap(1),
      //       ),
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 2
      //             ? Image.asset('assets/appbar/reservation_filled.png')
      //             : Image.asset('assets/appbar/reservation.png'),
      //         onPressed: () {
      //           _appBarIconTap(2);
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const PlaceOrder()),
      //           );
      //         },
      //       ),
      //       IconButton(
      //         icon: _selectedAppBarIconIndex == 3
      //             ? Image.asset('assets/appbar/profile_filled.png')
      //             : Image.asset('assets/appbar/profile.png'),
      //         onPressed: () {
      //           _appBarIconTap(3);
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => SaveItem()),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Future<void> saveItem(ItemModel item) async {
    try {
      final dbContextReference = FirebaseDatabase.instance.ref().child('items');

      dbContextReference.child(item.id).set(({
            'id': item.id,
            'name': item.name,
            'category': item.category,
            'quantity': item.quantity,
            'price': item.price,
            'desctiption': item.description,
          }));

      Fluttertoast.showToast(
          msg: "Item Saved Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: const Color(0xff5db075),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (exception) {
      Fluttertoast.showToast(
          msg: "Error has been occured pleas try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: const Color.fromARGB(255, 233, 23, 23),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
