import 'package:flutter/material.dart';

class DiaryDetailAlbum extends StatefulWidget {
  const DiaryDetailAlbum({super.key});

  @override
  State<DiaryDetailAlbum> createState() => _DiaryDetailAlbumState();
}

class _DiaryDetailAlbumState extends State<DiaryDetailAlbum> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 110,
        height: 110,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'lib/assets/images/test_couple.png',
              fit: BoxFit.cover,
            )));
  }
}
