import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../widget/login/kakao_login.dart';

class UserProvider extends ChangeNotifier{
  final TextEditingController _nickNameTextEditController = TextEditingController();
  // final TextEditingController _contentTextEditController = TextEditingController();

  TextEditingController get nickNameTextEditController => _nickNameTextEditController;
  // TextEditingController get contentTextEditController => _contentTextEditController;

  bool checkProvider(TextEditingController textEditingController){
    if(textEditingController.text.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

  // void resetProvider(){
  //   _titleTextEditController.clear();
  //   _contentTextEditController.clear();
  //   _image = null;
  // }

  // void setTitleController(String title){
  //   _titleTextEditController.text = title;
  //   notifyListeners();
  // }

  // void setContentController(String content){
  //   _contentTextEditController.text = content;
  //   notifyListeners();
  // }

  // void setImage(XFile? imagePath){
  //   _image = imagePath;
  //   notifyListeners();
  // }

  // @override
  // void dispose() {
  //   _titleTextEditController.dispose();
  //   _contentTextEditController.dispose();
  //   super.dispose();
  // }
}






// class UserControlProvider with ChangeNotifier {
//   User? _user;
//   KakaoLoginApi kakaoLoginApi;
//   User? get user => _user;
//
//   UserControlProvider({required this.kakaoLoginApi});
//
//   // 카카오 로그인
//   void kakaoLogin() async {
//     kakaoLoginApi.signWithKakao().then((user) {
//       // 반환된 값이 NULL이 아니라면
//       // 정보 전달
//       if (user != null) {
//         _user = user;
//         notifyListeners();
//       }
//     });
//   }
// }