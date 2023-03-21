import 'dart:io';

import 'package:automobile_spare_parts_app/data/models/item.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class SaveItem extends StatefulWidget {
  const SaveItem({super.key});

  @override
  State<SaveItem> createState() => _SaveItemState();
}

class _SaveItemState extends State<SaveItem> {
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
    return Container(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16),
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
                    image: DecorationImage(image: FileImage(image!))),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 4, color: Colors.white),
                    color: Colors.green,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: const Icon(Icons.camera_alt_outlined,
                          color: Colors.black)),
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
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  hintText: 'Enter Quantity',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 14.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromARGB(255, 217, 217, 217)),
                                    borderRadius: new BorderRadius.circular(8),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromARGB(255, 217, 217, 217)),
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
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  hintText: 'Enter Price',
                                  enabled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 14.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromARGB(255, 217, 217, 217)),
                                    borderRadius: new BorderRadius.circular(8),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromARGB(255, 217, 217, 217)),
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
                              MaterialStateProperty.all(Colors.green),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
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
    } catch (exception) {}
  }
}
