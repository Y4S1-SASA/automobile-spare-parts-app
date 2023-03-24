// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../service/order.service.dart';
import '../../../../../utils.dart';
import '../constants.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class LocationPicker extends StatefulWidget {
  TextEditingController controller;
  final ValueChanged<String> onChanged;

  LocationPicker(
      {super.key, required this.controller, required this.onChanged});

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  var uuid = Uuid();
  String _sessionToken = '1222555';
  List<dynamic> _placesList = [];
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final OrderService _orderService = OrderService();

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggesstion(widget.controller.text);
  }

  void getSuggesstion(String input) async {
    String PLACES_API_KEY = "AIzaSyBTbf4elIdOrbCSicNAhA0A61sHjMd9aV4";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print('data');

    print(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return SimpleDialog(
      title: const Text(Constants.LOCATION_PICKER_TITLE),
      contentPadding: const EdgeInsets.all(20),
      children: [
        Container(
          // input fields
          margin: EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32.41 * fem, 22 * fem),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8.52 * fem),
                child: Text(
                  'Enter Delivery Address',
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 12 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.2125 * ffem / fem,
                    color: const Color(0xff666666),
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffe7e7e7)),
                    color: const Color(0xfff6f6f6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: widget.controller,
                    onChanged: (value) {
                      setState(() {
                        widget.onChanged(value);
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 14.0),
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2125 * ffem / fem,
                        color: const Color(0xffbdbdbd),
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.2125 * ffem / fem,
                      color: const Color(0xff666666),
                    ),
                  )),
              SizedBox(
                width: 340 * fem,
                height: 200,
                child: Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        widget.onChanged(_placesList[index]['description']);
                        Navigator.pop(context);
                        widget.controller.clear();
                      });
                    },
                    title: Text(_placesList[index]['description']),
                  );
                })),
              ),
            ],
          ),
        )
      ],
    );
  }
}
