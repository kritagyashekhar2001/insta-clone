import 'package:flutter/cupertino.dart';
import 'package:insta_clone/function/signup_model.dart';
import 'package:insta_clone/models/user.dart';

class Userprovider with ChangeNotifier {
  User? _usr;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _usr!;
  Future<void> refreshUser() async {
    User userr = await _authMethods.getUserDetails();
    _usr = userr;
    notifyListeners();
  }
}
