import 'package:automobile_spare_parts_app/view/base/footer.widget.dart';
import 'package:automobile_spare_parts_app/view/base/heading.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '/utils.dart';

class Scene extends StatefulWidget {
  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _tagsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 445;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SingleChildScrollView(
      child: Container(
        // articlescreatebq2 (10:678)
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffececec)),
          color: Color(0xffffffff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // autogroupyq5usGk (2G1d1Cw1Lk4a1AbVs8yQ5u)
              padding:
                  EdgeInsets.fromLTRB(0 * fem, 21.79 * fem, 0 * fem, 0 * fem),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Heading(),
                  Container(
                    // group47wA8 (10:1628)
                    margin: EdgeInsets.fromLTRB(
                        9 * fem, 0 * fem, 0 * fem, 47.64 * fem),
                    width: 242 * fem,
                    height: 149 * fem,
                    child: Image.asset(
                      'assets/page-1/images/group-47.png',
                      width: 242 * fem,
                      height: 149 * fem,
                    ),
                  ),
                  Container(
                    // group40rH6 (10:1178)
                    margin: EdgeInsets.fromLTRB(
                        32 * fem, 0 * fem, 32 * fem, 179 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroup8pfrysW (2G1dHnHip4VR5KhvaR8pfR)
                          padding: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 22 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // inputtextW6k (10:805)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0.41 * fem, 22 * fem),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // titleqep (10:806)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 0 * fem, 8.88 * fem),
                                      child: Text(
                                        'Title',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(16 * fem,
                                          19 * fem, 16 * fem, 16.48 * fem),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffe7e7e7)),
                                        color: Color(0xfff6f6f6),
                                        borderRadius:
                                            BorderRadius.circular(8 * fem),
                                      ),
                                      child: TextFormField(
                                        controller: _titleController,
                                        decoration: InputDecoration(
                                          hintText:
                                              'Enter title for the article',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xffbdbdbd),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // inputtext1hi (10:808)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0.41 * fem, 0 * fem),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // descriptionk9W (10:809)
                                      margin: EdgeInsets.fromLTRB(0 * fem,
                                          0 * fem, 0 * fem, 8.52 * fem),
                                      child: Text(
                                        'Description',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(16 * fem,
                                          19 * fem, 16 * fem, 16.48 * fem),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffe7e7e7)),
                                        color: Color(0xfff6f6f6),
                                        borderRadius:
                                            BorderRadius.circular(8 * fem),
                                      ),
                                      child: TextFormField(
                                        controller: _descriptionController,
                                        decoration: InputDecoration(
                                          hintText:
                                              'Enter a description for the article',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 16 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2125 * ffem / fem,
                                            color: Color(0xffbdbdbd),
                                          ),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.2125 * ffem / fem,
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // group39LNc (10:1172)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 40 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // tagsgBa (10:1173)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 9 * fem),
                                child: Text(
                                  'Tags',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xff666666),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    16 * fem, 19 * fem, 16 * fem, 16.48 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffe7e7e7)),
                                  color: Color(0xfff6f6f6),
                                  borderRadius: BorderRadius.circular(8 * fem),
                                ),
                                child: TextFormField(
                                  controller: _tagsController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter tags separated by commas',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2125 * ffem / fem,
                                      color: Color(0xffbdbdbd),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2125 * ffem / fem,
                                    color: Color(0xff666666),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // group6fJQ (10:1168)
                          margin: EdgeInsets.fromLTRB(
                              55 * fem, 0 * fem, 56 * fem, 0 * fem),
                          width: double.infinity,
                          height: 45 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30 * fem),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Function to be executed when button is pressed
                              print(_titleController.text);
                            },
                            child: Container(
                              // group5CJL (10:1169)
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xff5db075),
                                borderRadius: BorderRadius.circular(30 * fem),
                              ),
                              child: Center(
                                child: Text(
                                  'Create Article',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 18 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3333333333 * ffem / fem,
                                    letterSpacing: 0.150000006 * fem,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
