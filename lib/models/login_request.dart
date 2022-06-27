import 'dart:async';
import 'package:telalogin/models/user.dart';
import 'package:telalogin/models/login_ctr.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();
  Future<User?> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }
}
