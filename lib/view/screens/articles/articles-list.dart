import 'package:automobile_spare_parts_app/data/models/article.modal.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-create.dart';
import 'package:automobile_spare_parts_app/view/screens/articles/articles-edit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/utils.dart';

class ListArticles extends StatefulWidget {
  @override
  State<ListArticles> createState() => _ListArticlesState();
}

class _ListArticlesState extends State<ListArticles> {
  final List<ArticleModal> articlesList = [];

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  getArticles() async {
    final snapshot = await FirebaseDatabase.instance.ref('articles').get();

    final map = snapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      List<String> tagsList = [];

      value["tags"].forEach((tag) {
        tagsList.add(tag.toString());
      });

      ArticleModal article = ArticleModal(
          key: key,
          title: value["title"],
          description: value["description"],
          tags: tagsList,
          imageUrl: value["imageUrl"],
          ownerUid: value["ownerUid"]);
      setState(() {
        articlesList.add(article);
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
          title: Text('Articles'),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Container(
              // articleslistdip (9:418)
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffececec)),
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // addZeG (10:579)
                    margin: EdgeInsets.fromLTRB(
                        1 * fem, 20 * fem, 0 * fem, 34 * fem),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Scene()));
                        },
                        child: Container( child: Text(
                          'Add',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2125 * ffem / fem,
                            color: Color(0xff5db075),
                          ),
                        )),
                  ),),
                  Container(
                    // inputsearchGYg (10:636)
                    margin: EdgeInsets.fromLTRB(
                        25 * fem, 0 * fem, 24 * fem, 33 * fem),
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 20 * fem, 16 * fem, 18 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/page-1/images/bg-hya.png',
                        ),
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                        height: 1.2125 * ffem / fem,
                        color: Color(0xffbdbdbd),
                      ),
                    ),
                  ),
                  Container(
                    // autogroup1krs4Sk (2G1LrfqWb4Yvf5s1h81krs)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 0 * fem),
                    width: double.infinity,
                    height: 1072 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // group29nde (10:562)
                          left: 21 * fem,
                          top: 0 * fem,
                          child: Container(
                            width: 403 * fem,
                            height: 1072 * fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: articlesList
                                  .map((article) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditArticle(
                                                        article: article)));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            25 * fem, 0 * fem, 0 * fem),
                                        // contentcontentblocklargeHaQ (9:522)
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Image.network(
                                                  article.imageUrl),
                                              // contentblockQ9E (I9:522;150:1080)
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
                                              // header7pL (I9:522;150:1081)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  7 * fem),
                                              child: Text(
                                                article.title,
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
                                              // texttimee3a (I9:522;150:1086)
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // hellwanttouseyouryachtandidont (I9:522;150:1083)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        8 * fem),
                                                    constraints: BoxConstraints(
                                                      maxWidth: 404 * fem,
                                                    ),
                                                    child: Text(
                                                      article.description,
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 14 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height:
                                                            1.2125 * ffem / fem,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                      child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children:
                                                        article.tags.map((tag) {
                                                      return Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                2 * fem,
                                                                0 * fem),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 6,
                                                                vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Text(
                                                          tag,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ))
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
        ));
  }
}