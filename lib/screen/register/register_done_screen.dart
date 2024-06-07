import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/screen/main_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/enums.dart';
import '../../model/user_model.dart';
import '../../style/font.dart';

class RegisterDoneScreen extends StatefulWidget {
  const RegisterDoneScreen({super.key, required this.title});

  final String title;

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
                Container(
                    height: deviceHeight - 40,
                    width: deviceWidth - 40,
                    child: Column(
                      children: [
                        Container(
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "지금부터 ",
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 18,
                                        fontFamily: FontFamily.mapleStoryLight),
                                  ),
                                  Text(
                                    "멋쟁이사자",
                                    style: TextStyle(
                                        color: ColorFamily.black,
                                        fontSize: 20,
                                        fontFamily: FontFamily.mapleStoryBold),
                                  ),Text(
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
                                      //TODO user데이터모델 서버에 저장

                                      // 자동로그인
                                      // write 함수를 통하여 key에 맞는 정보를 적게 됩니다.
                                      //{"login" : "id id_value password password_value"}
                                      //와 같은 형식으로 저장이 된다고 생각을 하면 됩니다.
                                      if(userProvider.loginType == LoginType.google){
                                      await storage.write(
                                      key: "loginData",
                                      value: "googleUser?.id");
                                      } else{
                                      await storage.write(
                                      key: "loginData",
                                      value: "OAuthToken.accessToken");
                                      }
                                      runApp(const MainScreen(loginData: "loginData"));
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