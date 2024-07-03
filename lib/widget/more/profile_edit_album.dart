import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../style/color.dart';
import '../../style/text_style.dart';

class ProfileEditAlbum extends StatefulWidget {
  const ProfileEditAlbum({super.key});

  @override
  State<ProfileEditAlbum> createState() => _ProfileEditAlbumState();
}

class _ProfileEditAlbumState extends State<ProfileEditAlbum> {
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  dynamic userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        splashColor: ColorFamily.cream,
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          _showModalBottomSheet(context);
        },
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: ColorFamily.white,
              border: Border.all(width: 0.1, color: ColorFamily.gray)),
          child: SvgPicture.asset(
            'lib/assets/icons/camera.svg',
            width: 20,
            height: 20,
            fit: BoxFit.none,
          ),
        ),
      ),
    );
  }

  Future<void> getImage(UserModel userProvider, ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        // userProvider.setImage(XFile(pickedFile.path));
        // userProvider.userProfileImage = userProvider.image!.path;
      });
    }
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        backgroundColor: ColorFamily.white,
        builder: (context) {
          return Wrap(
            children: [
              Column(
                children: [
                  InkWell(
                    splashColor: ColorFamily.gray.withOpacity(0.5),
                    onTap: () {
                      getImage(userProvider, ImageSource.gallery);
                      Navigator.pop(context);
                      // FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('lib/assets/icons/gallery.svg', height: 20,),
                          const Text(
                            "앨범에서 사진 선택",
                            style: TextStyleFamily.smallTitleTextStyle,
                          ),
                          const SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 0.5,
                    child: Divider(
                      color: ColorFamily.gray,
                      thickness: 0.5,
                    ),
                  ),
                  InkWell(
                    splashColor: ColorFamily.gray.withOpacity(0.5),
                    onTap: () {
                      setState(() {
                        userProvider.userProfileImage =
                            "lib/assets/images/default_profile.png";
                        userProvider.setImage(null);
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset('lib/assets/icons/profile_icon.svg', height: 20),
                          const Text(
                            "기본 프로필 사진으로 설정",
                            style: TextStyleFamily.smallTitleTextStyle,
                          ),
                          const SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
