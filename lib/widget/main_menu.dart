import '../screen/about_screen.dart';
import '../screen/poem_list.dart';

import '../screen/generate_faal.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          RaisedButton(
            child: Text(
              ' فال حافظ'
            ),
            onPressed: () => {openGenerateFaalScreen(context)},
          ),

          RaisedButton(
            child: Text('غزلیات'),
            onPressed: () => {openPoemListScreen(context)},
          ),

          RaisedButton(
            child: Text('درباره'),
            onPressed: () => {openAboutScreen(context)},
          ),

        ],

      ),
    );
  }

  openGenerateFaalScreen(BuildContext context) {
    Navigator.of(context).pushNamed(GenerateFaalScreen.ROUTE_NAME);
  }

  openPoemListScreen(BuildContext context) {
    Navigator.of(context).pushNamed(PoemListScreen.ROUTE_NAME);
  }

  openAboutScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AboutScreen.ROUTE_NAME);
  }
}
