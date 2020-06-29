import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('برنامه نویس: علی خالقی'),
            ]),
      ),
    );
  }
}
