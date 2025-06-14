import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:geco_app/pages/dashboard_page.dart';
// import 'package:geco_app/controller/user_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:mijn_visie_app/controllers/user_controller.dart';
import 'package:mijn_visie_app/pages/base.dart';
import 'package:mijn_visie_app/pages/signup.dart';
// import 'package:geco_app/pages/passw
// ord_reset_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String routeName = "/login";

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                  child: Card(
                      child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) {
                              if (email == null || email.isEmpty) {
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
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (password) {
                              if (password == null || password.isEmpty) {
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
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Forgot password?',
                    //     style: const TextStyle(
                    //         color: Colors.black,
                    //         decoration: TextDecoration.underline),
                    //     recognizer: TapGestureRecognizer()
                    //       ..onTap = () {
                    //         Get.to(() => const PasswordResetPage());
                    //       },
                    //   ),
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          var email = _emailController.text;
                          var password = _passwordController.text;
                          _passwordController.clear();
                          bool loggedIn =
                              await _userController.login(email, password);
                          if (loggedIn) {
                            Get.offAll(() => BasePage());
                          } else {
                            Get.snackbar('Sign in failed', 'Email or password was incorrect');
                          }
                        }
                      },
                      child: const Text("Sign In"),
                    ),
                    // ElevatedButton.icon(
                    //   // style: ElevatedButton.styleFrom(
                    //   //   primary: Colors.white,
                    //   //   onPrimary: Colors.black,
                    //   //   shadowColor: Colors.blue,
                    //   //   minimumSize: const Size(double.infinity, 50),
                    //   // ),
                    //   icon: const FaIcon(
                    //     FontAwesomeIcons.google,
                    //     color: Colors.blue,
                    //   ),
                    //   label: const Text('Sign in with Google'),
                    //   onPressed: () async {
                    //     bool loggedIn = await _userController.googleLogin();
                    //     if (loggedIn) {
                    //       Get.offAll(() => DashboardPage());
                    //     }
                    //   },
                    // ),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            const TextSpan(
                                text: 'Don\'t have an account yet? '),
                            TextSpan(
                              text: 'Sign Up',
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => const SignupPage());
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
            )),
          ],
        ));
  }
}
