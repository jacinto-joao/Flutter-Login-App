import 'package:flutter/material.dart';

class UserRepository {
  Future<String> authenticate({@required username, @required password}) async {
    Future.delayed(Duration(seconds: 2));
    return 'token';
  }

  Future<void> deleteToken() async {
    Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<void> persistToken(String token) async {
    Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<bool> hasToken() async {
    Future.delayed(Duration(seconds: 2));
    return false;
  }
}
