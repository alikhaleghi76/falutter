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
            onPressed: () => {},
          ),

          RaisedButton(
            child: Text('درباره'),
            onPressed: () => {},
          ),

        ],

      ),
    );
  }

  openGenerateFaalScreen(BuildContext context) {
    Navigator.of(context).pushNamed(GenerateFaalScreen.ROUTE_NAME);
  }
}
