import 'dart:math';

import '../screen/view_faal.dart';
import 'package:flutter/material.dart';

class GenerateFaalScreen extends StatelessWidget {

  static const String ROUTE_NAME = '/generate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('نیت کرده و دکمه مشاهده فال را انتخاب کنید.'),
          RaisedButton(
            child: Text('مشاهده فال'),
            onPressed: () {
              openFaalScreen(context);
            },
          )],
        ),
      ),
    );
  }

  void openFaalScreen(BuildContext context) {
    var random = new Random();
    Navigator.of(context).pushNamed(ViewFaalScreen.ROUTE_NAME, arguments: {
      "id": random.nextInt(495)
    });
  }
}
