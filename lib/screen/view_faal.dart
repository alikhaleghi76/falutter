import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sqflite/sqflite.dart';

import '../data/database_connection.dart';
import '../model/faal.dart';

class ViewFaalScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/faal';

  @override
  _ViewFaalScreenState createState() => _ViewFaalScreenState();
}

class _ViewFaalScreenState extends State<ViewFaalScreen> {
  Faal faal;
  int faalID;
  bool showInterpretation = true;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    String poem = "";
    if (faal != null) {
      List<String> parts = faal.poem.split("\n");
      for (int i = 0; i < parts.length; i++) {
        poem += parts[i];
        if (i < parts.length - 2) {
          if (i % 2 == 0)
            poem += "\n";
          else
            poem += "\n\n";
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((faal != null) ? 'غزل شماره ${faal.id}' : ''),
      ),
      body: Builder(
        builder: (context) => Container(
          width: double.infinity,
          child: (faal != null)
              ? SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 32, left: 32, top: 24, bottom: 24),
                    child: Column(children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(
                          poem,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.content_copy),
                              color: Colors.grey,
                              tooltip: 'کپی کردن',
                              onPressed: () {
                                copyToClipboard(context, poem);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              color: Colors.grey,
                              tooltip: 'اشتراک گذاری',
                              onPressed: () {
                                shareText(context, poem);
                              },
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: showInterpretation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Divider(
                              height: 48,
                            ),
                            Text(
                              'تفسیر فال',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                faal.interpretation,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.content_copy),
                                    color: Colors.grey,
                                    tooltip: 'کپی کردن',
                                    onPressed: () {
                                      copyToClipboard(context, faal.interpretation);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    color: Colors.grey,
                                    tooltip: 'اشتراک گذاری',
                                    onPressed: () {
                                      shareText(context, faal.interpretation);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                )
               : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future<Database> futureDB = initDatabase();
    futureDB.then((db) {
      Map<String, Object> args =
          (ModalRoute.of(context).settings.arguments as Map<String, Object>);
      print(args);

      faalID = args['id'] as int;
      print(faalID);

      if (args.containsKey('show_interpretation'))
        showInterpretation = args['show_interpretation'] as bool;

      if (args.containsKey('search_query'))
        searchQuery = args['search_query'] as String;

      Future<Faal> futureFaal = getFaalFromDB(db, faalID);
      futureFaal.then((faal) {
        print(faal);
        setState(() {
          print(searchQuery);
          if (faal != null &&
              searchQuery != null &&
              searchQuery.isNotEmpty &&
              faal.poem.contains(searchQuery))
            faal.poem = faal.poem.replaceAll(searchQuery, "«$searchQuery»");

          this.faal = faal;
        });
      });
    });
  }

  Future<Database> initDatabase() async {
    Future<Database> dbFuture = DatabaseConnection.initDB();
    return dbFuture;
  }

  Future<Faal> getFaalFromDB(Database database, int faalID) async {
    List<Map<String, dynamic>> result = await database
        .rawQuery("SELECT * FROM faals WHERE id = ?", ['$faalID']);
    print(result);
    Faal faal = Faal(int.parse(result[0]['id']), result[0]['Poem'],
        result[0]['Interpretation']);
    return faal;
  }

  void copyToClipboard(BuildContext context, String text) {
    ClipboardManager.copyToClipBoard(text).then((result) {
      final snackBar = SnackBar(
        content: Text(
          'در حافظه ذخیره شد.',
          style: TextStyle(fontFamily: 'Vazir'),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void shareText(BuildContext context, String text) {
    final RenderBox box = context.findRenderObject();
    Share.share(text,
        subject: 'فال حافظ',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
