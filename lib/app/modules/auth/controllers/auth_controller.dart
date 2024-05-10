import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  void login(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      // Show Snackbar if any field is empty
      Get.snackbar('Error', 'All fields are required!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
    } else {
      Get.toNamed('/home');
    }
  }

  void register(String username, String fullName, String nim, String phone,
      String password) {
    if (username.isEmpty ||
        fullName.isEmpty ||
        nim.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      Get.snackbar('Registration Error', 'All fields must be filled!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));
    } else {
      Get.snackbar(
          'Registration Successful', 'You are now registered. Please log in.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: Duration(seconds: 3));

      Future.delayed(Duration(seconds: 3), () {
        Get.offAllNamed('/login');
      });
    }
  }
}
