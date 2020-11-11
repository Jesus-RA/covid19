import 'package:flutter/material.dart';

import 'package:covid19/src/pages/home_page.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodboy Covid-19',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}