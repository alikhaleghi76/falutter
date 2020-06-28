import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Text('درباره من'),
          onPressed: () => {},
        ),

      ],

    );
  }
}
