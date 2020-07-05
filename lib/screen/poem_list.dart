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
  List<Faal> searchResult = List();

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

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
        leading: _isSearching ? Container() : BackButton(),
        title: _isSearching ? _buildSearchField() : Text('فهرست غزلیات'),
        actions: _buildActions(),
      ),
      body: Container(
        width: double.infinity,
        child: (_isSearching ? searchResult != null : faals != null)
            ? ListView.separated(
                itemCount: _isSearching ? searchResult.length : faals.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      title: Text('غزل شماره ${_isSearching ? searchResult[index].id : faals[index].id}'),
                      subtitle: Text(
                        '${_isSearching ? searchResult[index].poem : faals[index].poem}',
                        maxLines: 1,
                      ),
                    ),
                    onTap: () {
                      if (_isSearching) {
                        openFaalScreen(context, searchResult[index].id, searchQuery: searchQuery);
                      } else {
                        openFaalScreen(context, faals[index].id);
                      }
                    },
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

  Future<List<Faal>> searchFaals(Database database, String query) async {
    print('SEARCHING FAALS');
    if (query.isEmpty) return faals;
    List<Faal> searchResult = List();
    faals.forEach((faal) {
      if (faal.id.toString().contains(query) ||
          faal.poem.contains(query))

        searchResult.add(faal);

    });
    return searchResult;
  }

  openFaalScreen(BuildContext context, int id, {String searchQuery}) {
    Navigator.of(context).pushNamed(ViewFaalScreen.ROUTE_NAME,
        arguments: {'id': id, 'show_interpretation': false, 'search_query': searchQuery});
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "متن جستجو...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(_searchQueryController.text),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    print("UPDATED");
    Future<Database> futureDB = initDatabase();
    futureDB.then((db) {
      Future<List<Faal>> futureFaal = searchFaals(db, newQuery);
      futureFaal.then((searchResult) {
        print(searchResult.length);
        setState(() {
          this.searchResult = searchResult;
        });
      });
    });

    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
