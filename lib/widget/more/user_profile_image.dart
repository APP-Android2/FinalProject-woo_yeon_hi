import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/dao/diary_dao.dart';
import 'package:woo_yeon_hi/model/diary_model.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

import '../../dao/user_dao.dart';
import '../../model/user_model.dart';

class UserProfileImage extends StatefulWidget {
  UserProfileImage({required this.profileImagePath, super.key});
  String profileImagePath;

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  late Image userProfileImageFile;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    var userProvider = Provider.of<UserModel>(context, listen: false);

    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(65),
      child: InkWell(
        borderRadius: BorderRadius.circular(65),
        splashColor: Colors.transparent,
        child: FutureBuilder<Image>(
          future: getUserProfileImage(widget.profileImagePath),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return SizedBox(
            width: deviceWidth * 0.35,
            height: deviceWidth * 0.35,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(65),
                child: const SizedBox()
            ),
          );
        } else if (snapshot.hasError) {
          return const Text(
            "network error",
            style: TextStyleFamily.normalTextStyle,
          );
        } else {
          // userProvider.profileImageFile = snapshot.data!;
          return SizedBox(
            width: deviceWidth * 0.35,
            height: deviceWidth * 0.35,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(65),
                child: snapshot.data
            ),
          );
        }
      },
    ),

        // ClipRRect(
        //   child: userProvider.userProfileImage != "default_profile.png"
        //       ? Image.file(
        //       File(userProvider.image!.path),
        //       width: deviceWidth * 0.35,
        //       height: deviceWidth * 0.35,
        //       fit: BoxFit.cover)
        //       : Image.asset(
        //     profileImage,
        //     width: deviceWidth * 0.35,
        //     height: deviceWidth * 0.35,
        //   ),
        // ),

        onTap: () {
          widget.profileImagePath != "default_profile.png"
              ? showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    width: deviceWidth * 0.8,
                    height: deviceHeight * 0.6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.profileImagePath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              })
              : null;
        },
      ),
    );
  }
}
