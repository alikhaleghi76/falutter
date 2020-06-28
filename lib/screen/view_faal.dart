import 'dart:math';

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

  @override
  void initState() {
    super.initState();

    Future<Database> futureDB = initDatabase();
    futureDB.then((db) {
      Future<Faal> futureFaal = getFaalFromDB(db);
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
      appBar: AppBar(title: Text('غزل شماره ${faal.id}'),),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(faal.poem),
              Text(faal.interpretation),
            ],
          ),
        ),
      ),
    );
  }

  Future<Database> initDatabase() async {
    Future<Database> dbFuture = DatabaseConnection.initDB();
    return dbFuture;
  }

  Future<Faal> getFaalFromDB(Database database) async {
    var random = new Random();
    List<Map<String, dynamic>> result = await database.rawQuery(
        "SELECT * FROM faals WHERE id = ?", ['${random.nextInt(495)}']);
    Faal faal =
        Faal(int.parse(result[0]['id']), result[0]['Poem'], result[0]['Interpretation']);
    return faal;
  }
}
