import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screen/about_screen.dart';
import 'screen/generate_faal.dart';
import 'screen/poem_list.dart';
import 'screen/view_faal.dart';
import 'widget/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falutter',
      home: Scaffold(
        body: MainMenu(),
      ),
      routes: {
        GenerateFaalScreen.ROUTE_NAME: (context) => GenerateFaalScreen(),
        ViewFaalScreen.ROUTE_NAME: (context) => ViewFaalScreen(),
        PoemListScreen.ROUTE_NAME: (context) => PoemListScreen(),
        AboutScreen.ROUTE_NAME: (context) => AboutScreen(),

      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazir'
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"),
    );
  }

}