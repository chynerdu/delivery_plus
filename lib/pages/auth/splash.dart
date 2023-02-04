import 'package:deliveryplus/firebase_options.dart';
import 'package:deliveryplus/helpers/commom/route_constants.dart';
import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoggedIn = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).whenComplete(() {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            isLoggedIn = true;
            setState(() {});
          }
          initialize();
        });
      });
    });

    super.initState();
  }

  initialize() {
    Future.delayed(
        const Duration(seconds: 2),
        () => isLoggedIn
            ? Navigator.pushNamed(context, HomeRoute)
            : Navigator.pushNamed(context, LoginRoute));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: CustomColors.PrimaryColor,
          systemNavigationBarColor: CustomColors.PrimaryColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: CustomColors.AuthInput,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                    child: Text(
                  "Delivery Plus",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ))
              ],
            ),
          ),
        ));
  }
}
