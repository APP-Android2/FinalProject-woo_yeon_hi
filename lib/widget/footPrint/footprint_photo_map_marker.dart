import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/color.dart';

class PhotoMapMarker extends StatefulWidget {
  PhotoMapMarker(this.image, {super.key});
  String image;

  @override
  State<PhotoMapMarker> createState() => _PhotoMapMarkerState();
}

class _PhotoMapMarkerState extends State<PhotoMapMarker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: ColorFamily.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            )),
        SizedBox(
            width: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('lib/assets/icons/marker_point.svg'),
              ],
            ))
      ],
    );
  }
}
