import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mijn_visie_app/controllers/user_controller.dart';
import 'package:mijn_visie_app/pages/base.dart';

class SignupController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  UserController userController = Get.find();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    super.onClose();
  }

  /// Register function to check user input and call the register api
  void register() {
    if (loginFormKey.currentState!.validate()) {
      userController
          .register(firstnameController.text, lastnameController.text, emailController.text,
              passwordController.text, passwordController2.text)
          .then((auth) {
        if (auth) {
          Get.snackbar('Register', 'Registration successful');
          Get.offAll(() => BasePage());
        }
      });
      passwordController.clear();
      passwordController2.clear();
    }
  }
}
