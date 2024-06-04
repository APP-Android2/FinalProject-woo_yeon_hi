// import 'package:flutter/cupertino.dart';
// import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
//
// import '../widget/login/kakao_login.dart';
//
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