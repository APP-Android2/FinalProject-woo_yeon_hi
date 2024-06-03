import 'package:flutter/material.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_edit_album.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_edit_input.dart';
import 'package:woo_yeon_hi/widget/footPrint/footprint_history_edit_top_app_bar.dart';

import '../../style/color.dart';

class FootprintHistoryEditScreen extends StatefulWidget {
  const FootprintHistoryEditScreen({super.key});

  @override
  State<FootprintHistoryEditScreen> createState() => _FootprintHistoryEditScreenState();
}

class _FootprintHistoryEditScreenState extends State<FootprintHistoryEditScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorFamily.cream,
      appBar: FootprintHistoryEditTopAppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FootprintHistoryEditAlbum(),
              FootprintHistoryEditInput()
            ],
          ),
        ),
      ),

    );
  }
}
