import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_yeon_hi/provider/footprint_provider.dart';
import 'package:woo_yeon_hi/style/color.dart';

import '../../model/history_model.dart';
import '../../widget/footPrint/FootprintHistoryModifyAlbum.dart';
import '../../widget/footPrint/FootprintHistoryModifyTopAppBar.dart';
import '../../widget/footPrint/footprint_history_modify_input.dart';

class FootprintHistoryModifyScreen extends StatefulWidget {
  FootprintHistoryModifyScreen(this.history, {super.key});
  History history;

  @override
  State<FootprintHistoryModifyScreen> createState() =>
      _FootprintHistoryModifyScreenState();
}

class _FootprintHistoryModifyScreenState
    extends State<FootprintHistoryModifyScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FootprintHistoryEditProvider(),
      child: Consumer<FootprintHistoryEditProvider>(
        builder: (context, provider, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.modifySetting(widget.history);
          });
          return Scaffold(
            backgroundColor: ColorFamily.cream,
            appBar: FootprintHistoryModifyTopAppBar(provider, widget.history),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    FootprintHistoryModifyAlbum(provider, widget.history),
                    FootprintHistoryModifyInput(provider, widget.history)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
