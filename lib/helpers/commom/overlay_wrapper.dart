import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OverLayWrapper extends StatelessWidget {
  Widget child;
  OverLayWrapper({required this.child});
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: CustomColors.PrimaryColor,
          statusBarBrightness: Brightness.light,
        ),
        child: child);
  }
}
