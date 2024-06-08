import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woo_yeon_hi/style/color.dart';

Future<void> showColorPickerDialog(BuildContext context, Color currentColor, ValueChanged<Color> onColorChanged) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        backgroundColor: ColorFamily.white,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                direction: Axis.horizontal, // 정렬 방향
                alignment: WrapAlignment.start, // 정렬 방식
                spacing: 10, // 좌우 간격
                runSpacing: 5,  // 상하 간격
                children: [
                  _buildColorOption(context, Color(0xffFF806D), currentColor, onColorChanged),
                  _buildColorOption(context, Color(0xffFEBE98), currentColor, onColorChanged),
                  _buildColorOption(context, Color(0xffFFE08D), currentColor, onColorChanged),
                  _buildColorOption(context, Color(0xffD2E4CC), currentColor, onColorChanged),
                  _buildColorOption(context, Color(0xff66CBFF), currentColor, onColorChanged),
                  _buildColorOption(context, Color(0xff6295EE), currentColor, onColorChanged),
                  _buildColorOption(context, Color(0xffCC99FE), currentColor, onColorChanged),
                  _buildColorOption(context, Color(0xff564E5B), currentColor, onColorChanged),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildColorOption(BuildContext context, Color color, Color currentColor, ValueChanged<Color> onColorChanged) {
  return GestureDetector(
    onTap: () {
      onColorChanged(color);
      Navigator.of(context).pop();
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 100,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        if(currentColor == color)
          Positioned(
            child: SvgPicture.asset(
              "lib/assets/icons/done.svg",
              color: ColorFamily.white,
            ),
          )
      ],
    ),
  );
}