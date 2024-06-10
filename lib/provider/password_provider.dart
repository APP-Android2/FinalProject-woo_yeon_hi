import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screen/main_screen.dart';
import '../style/color.dart';

class PasswordEnterProvider extends ChangeNotifier {
  List<int> _checkingPasswordList = [];
  bool _firstNumInput = false;
  bool _secondNumInput = false;
  bool _thirdNumInput = false;
  bool _fourthNumInput = false;

  List<int> get checkingPasswordList => _checkingPasswordList;
  bool get firstNumInput => _firstNumInput;
  bool get secondNumInput => _secondNumInput;
  bool get thirdNumInput => _thirdNumInput;
  bool get fourthNumInput => _fourthNumInput;

  void addNumber(int number, BuildContext context) {
    if (_checkingPasswordList.length < 4) {
      setCheckingPasswordList(number);
    }
    if (_checkingPasswordList.length == 4) {
      checkPassword(context);
    }
    numInputCheck();
  }

  void removeNumber() {
    if (_checkingPasswordList.isNotEmpty) {
      _checkingPasswordList.removeLast();
    }
    numInputCheck();
  }

  void setCheckingPasswordList(int number){
    _checkingPasswordList.add(number);
    notifyListeners();
  }

  void checkPassword(BuildContext context) {
    var listEquality = const ListEquality();
    if (!listEquality.equals(_checkingPasswordList, [0,0,0,0])) {
      Fluttertoast.showToast(
          msg: "비밀번호가 일치하지 않습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorFamily.black,
          textColor: ColorFamily.white,
          fontSize: 14.0);
      Future.delayed(const Duration(milliseconds: 100), () {
        initiatePassword();
      });
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MainScreen()),
              (route) => false);
    }
  }

  void initiatePassword() {
    _firstNumInput = false;
    _secondNumInput = false;
    _thirdNumInput = false;
    _fourthNumInput = false;

    _checkingPasswordList.clear();
  }

  void numInputCheck() {
    _firstNumInput = _checkingPasswordList.length > 0;
    _secondNumInput = _checkingPasswordList.length > 1;
    _thirdNumInput = _checkingPasswordList.length > 2;
    _fourthNumInput = _checkingPasswordList.length > 3;
  }

  Widget buildPasswordIcon(bool isActive) {
    return isActive
        ? SvgPicture.asset("lib/assets/icons/woo_yeon_hi_48px.svg",
        width: 48, height: 48)
        : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SvgPicture.asset("lib/assets/icons/password_bar_24px.svg",
          width: 24),
    );
  }
}
