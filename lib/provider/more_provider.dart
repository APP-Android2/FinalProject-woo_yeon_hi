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

class AuthCodeProvider extends ChangeNotifier {
  bool _isAuthCodeGenerated = false;
  bool _isAuthCodeExpired = false;
  String _authCodeText = "";
  bool _showError = false;
  TextEditingController _authNumberTextEditController = TextEditingController();

  bool get isAuthCodeGenerated => _isAuthCodeGenerated;
  bool get isAuthCodeExpired => _isAuthCodeExpired;
  String get authCodeText => _authCodeText;
  bool get showError => _showError;
  TextEditingController get authNumberTextEditController => _authNumberTextEditController;

  void setIsAuthCodeGenerated(bool bool){
    _isAuthCodeGenerated = bool;
    notifyListeners();
  }

  void setIsAuthCodeExpired(bool bool){
    _isAuthCodeExpired = bool;
    notifyListeners();
  }

  void setAuthCodeText(String randomCode){
    _authCodeText = randomCode;
    notifyListeners();
  }

  void setShowError(bool isError){
    _showError = isError;
    notifyListeners();
  }
}
