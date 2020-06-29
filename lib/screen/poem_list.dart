import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../data/database_connection.dart';
import '../model/faal.dart';
import 'view_faal.dart';

class PoemListScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/list';

  @override
  _PoemListScreenState createState() => _PoemListScreenState();
}

class _PoemListScreenState extends State<PoemListScreen> {
  List<Faal> faals;

  @override
  void initState() {
    super.initState();

    Future<Database> futureDB = initDatabase();
    futureDB.then((db) {
      Future<List<Faal>> futureFaal = getFaalsFromDB(db);
      futureFaal.then((faals) {
        print(faals.length);
        setState(() {
          this.faals = faals;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('فهرست غزلیات'),
      ),
      body: Container(
        width: double.infinity,
        child: (faals != null)
            ? ListView.separated(
                itemCount: faals.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      title: Text('غزل شماره ${index + 1}'),
                      subtitle: Text(
                        '${faals[index].poem}',
                        maxLines: 1,
                      ),
                    ),
                    onTap: () => openFaalScreen(context, faals[index].id),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<Database> initDatabase() async {
    Future<Database> dbFuture = DatabaseConnection.initDB();
    return dbFuture;
  }

  Future<List<Faal>> getFaalsFromDB(Database database) async {
    List<Map<String, dynamic>> result =
        await database.rawQuery("SELECT * FROM faals");

    return result
        .map((faal) => Faal(
            (faal['id'] is int) ? faal['id'] : int.parse(faal['id']),
            faal['Poem'],
            faal['Interpretation']))
        .toList();
  }

  openFaalScreen(BuildContext context, int id) {
    Navigator.of(context).pushNamed(ViewFaalScreen.ROUTE_NAME, arguments: {
      'id': id,
      'show_interpretation': false
    });
  }
}
