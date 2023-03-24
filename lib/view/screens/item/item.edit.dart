import 'dart:io';
import 'package:automobile_spare_parts_app/data/models/item.model.dart';
import 'package:automobile_spare_parts_app/view/screens/item/item.market.list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import '/utils.dart';

class EditItemScreen extends StatefulWidget {
  EditItemScreen({Key? key, required this.itemModel}) : super(key: key);

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final quantityController = TextEditingController();
  final unitPriceController = TextEditingController();
  final descriptionController = TextEditingController();

  final ItemModel itemModel;

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  int _selectedAppBarIconIndex = 1;

  void _appBarIconTap(int index) {
    setState(() {
      _selectedAppBarIconIndex = index;
    });
  }

  File? _imageFile;
  final picker = ImagePicker();

  // Loads image image from source
  Future<void> getImageFromSource(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> showImageSourceSelectionDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    getImageFromSource(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    getImageFromSource(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // uploads image to firebase storage
  Future<String> seedItemImageAsync(BuildContext context) async {
    if (_imageFile == null) return "null";

    // Create a unique filename for the image
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload the image to Firebase Storage
    final storageRef =
        FirebaseStorage.instance.ref().child('item_images/$fileName');
    final uploadTask = storageRef.putFile(_imageFile!);
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    return imageUrl;
  }

  String selectedCategory = 'Item 1';
  final List<String> ctegories = [
    'Braking system',
    'Electrified powertrain components',
    'Engine components and parts',
    'Engine cooling system',
    'Engine oil systems',
    'Exhaust system',
    'Fuel supply system',
    'Suspension and steering systems',
  ];

  @override
  Widget build(BuildContext context) {
    widget.nameController.text = widget.itemModel.name;
    widget.quantityController.text = widget.itemModel.quantity.toString();
    widget.unitPriceController.text = widget.itemModel.price.toString();
    widget.descriptionController.text = widget.itemModel.description;
    selectedCategory = widget.itemModel.category;
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
                  child: widget.itemModel.imageUrl != null
                      ? Image.network(
                          widget.itemModel.imageUrl,
                          width: 242,
                          height: 149,
                        )
                      : Image.file(
                          _imageFile!,
                          height: 200,
                        ),
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
                      color: Color.fromARGB(255, 6, 84, 79),
                    ),
                    child: GestureDetector(
                        onTap: () async {
                          await showImageSourceSelectionDialog();
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
                          return "Item Name is required";
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
                                      return "Qunatity is required";
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
                                      return "Price is Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (value) {},
                                  keyboardType: TextInputType.number,
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
                          return "Description is Required";
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
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 6, 84, 79)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0)))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ItemModel itemModel = ItemModel(
                                id: widget.itemModel.id,
                                name: widget.nameController.text,
                                category: selectedCategory,
                                quantity:
                                    int.parse(widget.quantityController.text),
                                price: double.parse(
                                    widget.unitPriceController.text),
                                description: widget.descriptionController.text,
                                imageUrl: "",
                                createdBy: "");

                            updateItem(itemModel);
                          }
                        },
                        child: const Text(
                          'Update Item',
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
    );
  }

  Future<void> updateItem(ItemModel item) async {
    try {
      String? currentUserEmail = FirebaseAuth.instance.currentUser?.email;

      if (currentUserEmail != null) {
        final dbContextReference =
            FirebaseDatabase.instance.ref().child('items');
        //String imageUrl = await seedItemImageAsync(context);

        dbContextReference.child(item.id).update({
          'name': item.name,
          'category': item.category,
          'quantity': item.quantity,
          'price': item.price,
          'desctiption': item.description,
          'imageUrl': widget.itemModel.imageUrl,
          "createdBy": currentUserEmail,
        });

        Fluttertoast.showToast(
            msg: "Item Update Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 4,
            backgroundColor: Color.fromARGB(255, 4, 154, 89),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ItemMarketList()));
      } else {
        Fluttertoast.showToast(
            msg: "Authentication Error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 4,
            backgroundColor: Color.fromARGB(255, 192, 25, 25),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (exception) {
      Fluttertoast.showToast(
          msg: "Error has been occured pleas try again",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 4,
          backgroundColor: const Color.fromARGB(255, 233, 23, 23),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
