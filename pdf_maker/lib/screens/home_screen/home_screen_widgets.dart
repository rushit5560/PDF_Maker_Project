import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/common_widgets.dart';
import 'package:pdf_maker/common/img_url.dart';


class PickSingleImageModule extends StatelessWidget {
  const PickSingleImageModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: borderGradientDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: containerBackgroundGradient(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImgUrl.camera,
                    scale: 2.5,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Single Image",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PickMultiImageModule extends StatelessWidget {
  const PickMultiImageModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: borderGradientDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: containerBackgroundGradient(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImgUrl.camera,
                    scale: 2.5,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Multi Image",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MergePdfModule extends StatelessWidget {
  const MergePdfModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: borderGradientDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: containerBackgroundGradient(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImgUrl.camera,
                    scale: 2.5,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Merge PDF",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SavedPDfModule extends StatelessWidget {
  const SavedPDfModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: borderGradientDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: containerBackgroundGradient(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Saved PDF",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

