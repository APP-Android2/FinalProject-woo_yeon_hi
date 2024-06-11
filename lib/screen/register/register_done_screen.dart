import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../dao/user_dao.dart';
import '../../model/user_model.dart';
import '../../style/font.dart';

class RegisterDoneScreen extends StatefulWidget {
  RegisterDoneScreen({super.key, required this.title, required this.isHost});

  final String title;
  final bool isHost;

  @override
  State<RegisterDoneScreen> createState() => _RegisterDoneScreen();
}

class _RegisterDoneScreen extends State<RegisterDoneScreen>
    with TickerProviderStateMixin {
  static const storage = FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  dynamic userProvider;
  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: ColorFamily.cream,
          padding: const EdgeInsets.all(20),
          child: AnimatedBackground(
            behaviour:
            RandomParticleBehaviour(
              options: const ParticleOptions(
                opacityChangeRate: 25,
                spawnMinRadius: 10,
                spawnMaxRadius: 30,
                spawnMinSpeed: 30,
                spawnMaxSpeed: 50,
                particleCount: 30,
                minOpacity: 0.1,
                maxOpacity: 0.4,
                spawnOpacity: 0.5,
                baseColor: ColorFamily.cream,
                image: Image(image: AssetImage('lib/assets/images/heart_fill.png')),
              ),
            ),
            vsync: this,
            child: Column(
              children: [
                SizedBox(
                    height: deviceHeight - 40,
                    width: deviceWidth - 40,
                    child: Column(
                      children: [
                        SizedBox(
                            height: deviceHeight - 90,
                            width: deviceWidth - 40,
                            child: Column(children: [
                              SizedBox(
                                height: deviceHeight - 140,
                                width: deviceWidth - 40,
                                child: Column(children: [
                                    SizedBox(height: deviceHeight * 0.1),
                               const Text(
                                  "우연히",
                                  style: TextStyle(
                                      color: ColorFamily.pink,
                                      fontSize: 40,
                                      fontFamily: FontFamily.cafe24Moyamoya),
                                ),
                              SizedBox(height: deviceHeight * 0.2),
                              const Text(
                                "커플 등록이 완료되었습니다!",
                                style: TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 18,
                                    fontFamily: FontFamily.mapleStoryLight),
                              ),
                                    const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "지금부터 ",
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 18,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  ),
                                  Text(
                                    userProvider.loverNickname,
                                    style: const TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 20,
                                        fontFamily: FontFamily.mapleStoryBold),
                                  ),const Text(
                                    " 님과",
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 18,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "소중한 추억을 쌓아보세요!",
                                style: TextStyle(
                                    color: ColorFamily.black,
                                    fontSize: 18,
                                    fontFamily: FontFamily.mapleStoryLight),
                              )
                            ])),
                              SizedBox(
                                height: deviceHeight * 0.045,
                                width: deviceWidth * 0.75,
                                child: Material(
                                color: ColorFamily.white,
                                elevation: 1,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0),
                                ),
                                child: InkWell(
                                    onTap: () async {
                                      _saveUserData(context, userProvider);

                                      // 자동로그인, write 함수를 통하여 key에 맞는 정보를 적게 됩니다.
                                      await storage.write(
                                      key: "loginData",
                                      value: userProvider.userAccount);

                                      runApp(const MainScreen());
                                    },
                                    borderRadius:
                                    BorderRadius.circular(20.0),
                                    child: Container(
                                      decoration: BoxDecoration(border: Border.all(color: ColorFamily.pink,width: 0.5),borderRadius: BorderRadius.circular(20)),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "홈 화면으로 이동",
                                        style: TextStyleFamily.smallTitleTextStyle
                                      ),
                                    )),
                              ),
                              )

                      ],
                    )),
              ],
            ),
          ),
        ]))));
  }
}

Future<void> _saveUserData(BuildContext context, UserModel provider) async {
  var user_idx = await getUserSequence() + 1;
  await setUserSequence(user_idx);
  var login_type = provider.loginType;
  var user_account = provider.userAccount;
  var user_nickname = "기본닉네임";
  var user_birth = provider.userBirth;
  var user_profile_image = "";
  var lover_user_idx = 2;
  var lover_nickname = provider.loverNickname;
  var home_preset_type = provider.homePresetType;
  var top_bar_type = 0;
  var profile_message = "";
  var alarms_allow = false;
  var app_lock_state = 0;
  var top_bar_activate = false;
  var lock_password = [];
  var user_state = 1;
  var love_d_day = provider.loveDday;

  var user = UserModel(
      userIdx: user_idx,
      loginType: login_type,
      userAccount: user_account,
      userNickname: user_nickname,
      userBirth: user_birth,
      userProfileImage: user_profile_image,
      loverUserIdx: lover_user_idx,
      loverNickname: lover_nickname,
      homePresetType: home_preset_type,
      topBarType: top_bar_type,
      profileMessage: profile_message,
      alarmsAllow: alarms_allow,
      appLockState: app_lock_state,
      topBarActivate: top_bar_activate,
      lockPassword: lock_password,
      userState: user_state,
      loveDday: love_d_day
  );

  await saveUser(user);
  provider.providerNotify();
}