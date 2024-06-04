import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_history_screen.dart';
import 'package:woo_yeon_hi/screen/footPrint/footprint_photo_map_detail_screen.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/style/text_style.dart';

class FootprintPhotoMapScreen extends StatefulWidget {
  const FootprintPhotoMapScreen({super.key});

  @override
  State<FootprintPhotoMapScreen> createState() =>
      _FootprintPhotoMapScreenState();
}

class _FootprintPhotoMapScreenState extends State<FootprintPhotoMapScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => makePhotoMap(context, index));
  }

  Widget makePhotoMap(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FootprintPhotoMapDetailScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Card(
            color: ColorFamily.white,
            surfaceTintColor: ColorFamily.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 40 - 30,
                          child: Image.asset(
                            'lib/assets/images/korea_seoul.png',
                            fit: BoxFit.fitWidth,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 40 - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "지도 이름 $index",
                              style: TextStyleFamily.normalTextStyle,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {},
                                child: SvgPicture.asset(
                                    'lib/assets/icons/edit.svg'))
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {},
                      child: SvgPicture.asset('lib/assets/icons/delete.svg'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
