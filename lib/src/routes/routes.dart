import 'package:flutter/material.dart';

import 'package:covid19/src/pages/home_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    'homePage' : (BuildContext context) => HomePage(),
  };
}