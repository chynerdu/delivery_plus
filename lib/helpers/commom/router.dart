import 'package:deliveryplus/helpers/commom/route_constants.dart';
import 'package:deliveryplus/pages/auth/home.dart';
import 'package:deliveryplus/pages/auth/login.dart';
import 'package:deliveryplus/pages/auth/register.dart';
import 'package:deliveryplus/pages/auth/splash.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final arguments = settings.arguments as Map;
  Map arguments = (settings.arguments ?? {}) as Map;

  switch (settings.name) {
    case SplashRoute:
      return MaterialPageRoute(builder: (context) => Splash());

    case LoginRoute:
      return MaterialPageRoute(builder: (context) => Login());

    case RegisterRoute:
      return MaterialPageRoute(builder: (context) => Register());
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());

    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
