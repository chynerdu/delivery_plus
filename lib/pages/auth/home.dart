import 'dart:convert';

import 'package:deliveryplus/helpers/commom/customLoader.dart';
import 'package:deliveryplus/helpers/commom/customSnackbar.dart';
import 'package:deliveryplus/helpers/commom/dialog.dart';
import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:deliveryplus/pages/Main/newQuery.dart';
import 'package:deliveryplus/pages/Main/savedSearch.dart';
import 'package:deliveryplus/pages/Main/start.dart';
import 'package:deliveryplus/services/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  CustomSnackBar customSnackBar = CustomSnackBar();
  CustomLoader customLoader = CustomLoader();

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  CustomDialog customDialog = CustomDialog();

  void onItemTap(int index) {
    Controller c = Get.put(Controller());
    setState(() {
      c.updateTab(index);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    int backbuttonpressedTime = 0;

    // temporal hack
    final List<Widget> _tabs = <Widget>[
      NewQuery(),
      SavedSearch(),
    ];

    return WillPopScope(
        onWillPop: () async {
          const snackBar = SnackBar(
            content: Text(
              'Tap back again to leave',
            ),
          );
          var currentTime = DateTime.now().millisecondsSinceEpoch;

          if (currentTime - backbuttonpressedTime <
              const Duration(seconds: 2).inMilliseconds) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return false;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            backbuttonpressedTime = currentTime;
            return false;
          }
        },
        child: Obx(() => Scaffold(
              body: _tabs.elementAt(c.activeTab.value),
              key: drawerKey,
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.pin_drop, size: 20),
                    activeIcon: Icon(Icons.pin_drop,
                        size: 20, color: CustomColors.PrimaryColor),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history, size: 20),
                    activeIcon: Icon(Icons.history,
                        size: 20, color: CustomColors.PrimaryColor),
                    label: 'Saved Searches',
                  ),
                ],
                currentIndex: c.activeTab.value,
                backgroundColor: Colors.white,
                iconSize: 18,
                onTap: onItemTap,
                selectedFontSize: 14.0,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                unselectedFontSize: 14.0,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: CustomColors.PrimaryColor,
                unselectedItemColor: CustomColors.Grey,
                unselectedLabelStyle: const TextStyle(
                  color: CustomColors.Grey,
                ),
              ),
            )));
  }
}
