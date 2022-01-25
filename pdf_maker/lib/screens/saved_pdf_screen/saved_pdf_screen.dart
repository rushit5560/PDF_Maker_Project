import 'package:flutter/material.dart';
import 'package:pdf_maker/common/common_widgets.dart';

import 'saved_pdf_screen_widgets.dart';

class SavedPdfScreen extends StatelessWidget {
  const SavedPdfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MainBackgroundWidget(),

          SafeArea(
            child: Column(
              children: [
                CustomAppBar(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
