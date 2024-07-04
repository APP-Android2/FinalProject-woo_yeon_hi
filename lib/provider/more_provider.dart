import 'package:flutter/material.dart';

class BioAuthProvider extends ChangeNotifier{
  bool _bioAuthSupported = false;
  bool get bioAuthSupported => _bioAuthSupported;

  void setBioAuthSupported(bool value){
    _bioAuthSupported = value;
  }
}

class PasswordProvider extends ChangeNotifier {
  List<int> _password = [];
  List<int> get password => _password;

  void setPassword(List<int> passwordList) {
    _password = passwordList;
  }
}