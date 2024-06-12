import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:woo_yeon_hi/screen/home/home_screen_set1.dart';
import 'package:woo_yeon_hi/screen/home/home_screen_set2.dart';
import 'package:woo_yeon_hi/screen/home/home_screen_set3.dart';
import 'package:woo_yeon_hi/screen/home/home_screen_set4.dart';

import '../../dao/user_dao.dart';

class HomeScreenContainer extends StatefulWidget {
  const HomeScreenContainer({super.key});

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {
  static const storage = FlutterSecureStorage();
  late String userAccount = "";
  late int homePresetType = 0;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  Future<void> _asyncMethod() async {
    userAccount = (await storage.read(key: "loginAccount"))!;
    homePresetType = await getSpecificUserData(userAccount, 'home_preset_type');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _asyncMethod(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            return
              homePresetType==0
              ?HomeScreenSet1()
                  :homePresetType==1
                ?HomeScreenSet2()
                  :homePresetType==2
                ?HomeScreenSet3()
                  :HomeScreenSet4();
          }
        }
    );
  }
}
