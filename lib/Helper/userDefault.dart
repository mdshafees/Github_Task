import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/Model/ModelClass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDefault {
  static Future<SharedPreferences> getData() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences data = await getData();
    return data.getBool("loginStatus") ?? false;
  }

  static setLoginStatus(bool status) async {
    SharedPreferences data = await getData();
    data.setBool("loginStatus", status);
  }

  static setProfile(Profile user) async {
    SharedPreferences data = await getData();
    data.setString("profile", json.encode(user));
  }
}

class HelperWidgets {
  showSncakBar(context, msg) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.endToStart,
      content: Text(msg),
    ));
  }

  progressIndicator() {
    return Center(
        child: Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2)));
  }
}
