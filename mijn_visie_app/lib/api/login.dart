import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mijn_visie_app/main.dart';

import '../models/user.dart';


/// Returns the response of a GET request to the Geco API to route /users/details/ using [dio] as http client.
Future<User?> login(String email, String password) {
  return dioClient.post(
    "/login/access-token",
    options: Options(headers:{
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded'
    }),
    data: "grant_type=password&username=$email&password=$password"
  ).then((value) => dioClient.get("/users/me")
  ).then<User?>((value) => User.fromJson(value.data)
  ).catchError((err) => null);
}

Future<User?> register(String firstname, String lastname, String email, String password, String password2) {
  return dioClient.post(
    "/users/signup",
    data: {
      "email": email,
      "first_name": firstname,
      "last_name": lastname,
      "password": password
    }
  ).then<User?>((value) => User.fromJson(value.data)
  ).catchError((err) => null);;
}