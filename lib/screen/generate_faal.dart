import 'dart:math';

import 'package:flutter/material.dart';

import '../screen/view_faal.dart';

class GenerateFaalScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/generate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('فال حافظ'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('نیت کرده و دکمه دریافت فال را انتخاب کنید.'),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: RaisedButton(
                elevation: 2,
                color: Colors.green,
//                color: Color.fromARGB(255, 92, 240, 105),
                padding:
                    EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
//                shape: CircleBorder(),
                child: Text(
                  'دریافت فال',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => {openFaalScreen(context)},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openFaalScreen(BuildContext context) {
    var random = new Random();
    Navigator.of(context).pushNamed(ViewFaalScreen.ROUTE_NAME,
        arguments: {"id": random.nextInt(495)});
  }
}
