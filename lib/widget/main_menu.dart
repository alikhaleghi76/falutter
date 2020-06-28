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
            onPressed: () => {},
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
}
