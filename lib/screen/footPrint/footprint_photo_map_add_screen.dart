import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/style/color.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_photo_map_add_map_list.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_photo_map_add_top_app_bar.dart';

class FootprintPhotoMapAddScreen extends StatefulWidget {
  const FootprintPhotoMapAddScreen({super.key});

  @override
  State<FootprintPhotoMapAddScreen> createState() => _FootprintPhotoMapAddScreenState();
}

class _FootprintPhotoMapAddScreenState extends State<FootprintPhotoMapAddScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: FootprintPhotoMapAddTopAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          children: [
            Expanded(child: FootprintPhotoMapAddMapList())
          ],
        ),
      ),
    );
  }
}
