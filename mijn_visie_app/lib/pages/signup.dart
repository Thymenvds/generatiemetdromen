import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:mijn_visie_app/controllers/signup_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
      init: SignupController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                )),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Sign up",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Create an Account, Its free",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Form(
                            key: controller.loginFormKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  controller: controller.firstnameController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) {
                                    if (email!.isEmpty) {
                                      return 'Please enter a first name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter first name",
                                    labelText: "first name",
                                    prefixIcon: Icon(Icons.account_circle),
                                  ),
                                ),
                                TextFormField(
                                  controller: controller.lastnameController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) {
                                    if (email!.isEmpty) {
                                      return 'Please enter a last name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter last name",
                                    labelText: "last name",
                                    prefixIcon: Icon(Icons.account_circle),
                                  ),
                                ),
                                TextFormField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) {
                                    if (email!.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter email",
                                    labelText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),
                                TextFormField(
                                  controller: controller.passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  validator: (password) {
                                    if (password!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter password",
                                    labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                ),
                                TextFormField(
                                  controller: controller.passwordController2,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  validator: (password) {
                                    if (password!.isEmpty) {
                                      return 'Please repeat password';
                                    }
                                    if (controller.passwordController.text !=
                                        controller.passwordController2.text) {
                                      return "Password does not match";
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Enter password",
                                    labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  child: const Text("Submit"),
                                  onPressed: () {
                                    controller.register();
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(
                                    text: 'Already have an account? '),
                                TextSpan(
                                  text: 'Log In',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.back();
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
