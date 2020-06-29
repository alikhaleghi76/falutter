import 'package:flutter/material.dart';
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
      body: Container(
        width: double.infinity,
        child: (faal != null)
            ? SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.only(right: 32, left: 32, top: 24, bottom: 24),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Text(
                          poem,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Visibility(
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
                                  fontWeight: FontWeight.bold, ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Text(
                                faal.interpretation,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        visible: showInterpretation,
                      ),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator()),
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

      Future<Faal> futureFaal = getFaalFromDB(db, faalID);
      futureFaal.then((faal) {
        print(faal);
        setState(() {
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
}
