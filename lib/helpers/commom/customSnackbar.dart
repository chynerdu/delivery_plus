import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  showSuccessSnackBar({title, required body}) {
    Get.snackbar(
      title ?? "Success",
      body,
      icon: Icon(Icons.check, size: 25, color: Colors.green[600]),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 5),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  showErrorSnackBar(title) {
    Get.snackbar(
      "Error",
      "$title",
      icon: Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[600],
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 8),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  showWarningSnackBar(title) {
    Get.snackbar(
      "Warning",
      "$title",
      icon: Icon(Icons.warning, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orange[700],
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 5),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  showSnackBar(title, body) {
    Get.snackbar(
      "$title",
      "$body",
      icon: Icon(Icons.info, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  showInfoSnackBar({durationSeconds, title, required body}) {
    Get.snackbar(
      title ?? "Info",
      body,
      icon: Icon(Icons.info, size: 25, color: Colors.green[600]),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: durationSeconds ?? 8),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  showPaymentErrorSnackBar({durationSeconds, title, required body}) {
    Get.snackbar(
      title ?? "Error",
      body,
      icon: Icon(Icons.error, size: 25, color: Colors.green[600]),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: durationSeconds ?? 8),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
