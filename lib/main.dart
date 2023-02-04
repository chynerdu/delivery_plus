import 'package:deliveryplus/helpers/commom/loader.dart';
import 'package:deliveryplus/helpers/commom/route_constants.dart';
import 'package:deliveryplus/helpers/commom/router.dart' as router;
import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:deliveryplus/services/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  // await Firebase.initializeApp(

  // );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Obx(() {
      bool _isLoading = c.isLoading.toString() == 'true' ? true : false;
      return Directionality(
          textDirection: TextDirection.ltr,
          child: LoadingOverlay(
              progressIndicator: const SpinKitThreeBounce(
                color: CustomColors.PrimaryColor,
                size: 35,
              ),
              isLoading: _isLoading,
              child: GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Delivery Plus by Klasha',
                theme: ThemeData(
                  primarySwatch: Colors.orange,
                ),
                onGenerateRoute: router.generateRoute,
                initialRoute: SplashRoute,
                builder: EasyLoading.init(),
              )));
    });
  }
}
