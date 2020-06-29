import 'package:flutter/material.dart';

import '../screen/about_screen.dart';
import '../screen/generate_faal.dart';
import '../screen/poem_list.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double photoHeight = MediaQuery.of(context).size.height / 2;
    if (photoHeight > 180) photoHeight = 180;

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
                alignment: Alignment.bottomLeft,
                height: photoHeight,
                child: Image.asset(
                  'assets/images/hafiz.png',
                )),
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 180,
                    child: RaisedButton(
                      elevation: 2.0,
                      color: Color.fromARGB(255, 92, 240, 105),
                      padding: EdgeInsets.only(right: 40, left: 40, top: 16, bottom: 16),
//                    shape: CircleBorder(),
                      child: Text(' فال حافظ'),
                      onPressed: () => {openGenerateFaalScreen(context)},
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 90,
                          child: RaisedButton(
                            elevation: 2.0,
                            color: Color.fromARGB(255, 92, 220, 105),
                            padding: EdgeInsets.only(top: 16, bottom: 16),
//                          shape: CircleBorder(),
                            child: Text('غزلیات'),
                            onPressed: () => {openPoemListScreen(context)},
                          ),
                        ),
                        Container(
                          width: 90,
                          child: RaisedButton(
                            elevation: 2.0,
                            color: Color.fromARGB(255, 92, 198, 105),
                            padding: EdgeInsets.only(top: 16, bottom: 16),
//                          shape: CircleBorder(),
                            child: Text('درباره'),
                            onPressed: () => {openAboutScreen(context)},
                          ),
                        ),
                      ])
                ],
              ),
            ),
          ]),
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
