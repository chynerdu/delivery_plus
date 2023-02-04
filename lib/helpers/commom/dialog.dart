import 'dart:ui';

import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/shims/dart_ui_real.dart';

class CustomDialog {
  showCustomDialogModal(
      {required context,
      required title,
      required content,
      required okayAction,
      required declineAction}) async {
    return (await showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: CustomColors.PrimaryColor),
          ),
          content: Text(
            content,
            style: TextStyle(color: CustomColors.Grey),
          ),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          actions: <Widget>[
            TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: okayAction),
            TextButton(
                child: const Text(
                  'No',
                  style: TextStyle(color: CustomColors.PrimaryColor),
                ),
                onPressed: declineAction),
          ],
        ),
      ),
    ));
  }
}
