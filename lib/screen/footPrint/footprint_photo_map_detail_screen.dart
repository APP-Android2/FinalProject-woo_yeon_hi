import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_photo_map_detail_top_app_bar.dart';

import '../../style/color.dart';
import 'footprint_history_edit_screen.dart';

class FootprintPhotoMapDetailScreen extends StatefulWidget {
  const FootprintPhotoMapDetailScreen({super.key});

  @override
  State<FootprintPhotoMapDetailScreen> createState() => _FootprintPhotoMapDetailScreenState();
}

class _FootprintPhotoMapDetailScreenState extends State<FootprintPhotoMapDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: const FootprintPhotoMapDetailTopappBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorFamily.beige,
        shape: const CircleBorder(),
        child: SvgPicture.asset('lib/assets/icons/edit.svg'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FootprintHistoryEditScreen()));
        },
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1/2,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
            },
            child: Image.asset('lib/assets/images/korea_full.png', fit: BoxFit.contain,),
          ),
        ),
      ),

    );
  }
}
