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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('غزل شماره ${faalID}'),
      ),
      body: Container(
        width: double.infinity,
        child: (faal != null)
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(faal.poem),
                    Visibility(
                      child: Text(faal.interpretation),
                      visible: showInterpretation,
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
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
