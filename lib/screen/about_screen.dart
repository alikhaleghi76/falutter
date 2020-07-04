import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              FlatButton(onPressed: () {
                launch('https://github.com/alikhaleghi76');
              },
              child: Text('برنامه نویس: علی خالقی',
              style: TextStyle(
                color: Theme.of(context).accentColor
              ),),),
              FlatButton(onPressed: () {
                launch('https://github.com/mahmoud-eskandari/HafezFaalDatabase');
              },
              child: Text('گردآوری اشعار: محمود اسکندری',
              style: TextStyle(
                color: Theme.of(context).accentColor
              ),),),

            ]),
      ),
    );
  }
}
