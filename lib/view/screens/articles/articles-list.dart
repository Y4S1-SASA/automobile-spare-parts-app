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

  // Fetch articles from database and save them in state
  getArticles() async {
    setState(() {
      articlesList.clear();
    });
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
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
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
              SizedBox(
                height: 70,
              ),
              Text(
                "Articles",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(width: 48),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Scene()))
                        .then((_) => getArticles());
                  },
                  child: Container(
                      child: Text(
                    'Add',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Inter',
                      fontSize: 16,
                      color: Color(0xff5db075),
                    ),
                  )),
                ),
              ),
              Container(
                width: double.infinity,
                height: (345 * articlesList.length).toDouble(),
                alignment: Alignment.center,

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: articlesList
                        .map((article) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditArticle(article: article)))
                                  .then((_) => getArticles());
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 25),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Image.network(article.imageUrl),
                                    margin: EdgeInsets.only(bottom: 6),
                                    width: double.infinity,
                                    height: 240,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xfff6f6f6),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 6),
                                    child: Text(article.title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000))),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 6),
                                          constraints: BoxConstraints(
                                            maxWidth: 404,
                                          ),
                                          child: Text(article.description,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff000000))),
                                        ),
                                        Container(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: article.tags.map((tag) {
                                            return Container(
                                              margin: EdgeInsets.only(right: 5),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Text(
                                                tag,
                                                style: TextStyle(
                                                    color: Colors.white),
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

                // ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
