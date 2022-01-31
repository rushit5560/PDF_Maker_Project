import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_maker/common/custom_color.dart';
import 'package:pdf_maker/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:pdf_maker/controllers/pdf_merge_screen_controller/pdf_merge_screen_controller.dart';
import 'home_screen_widgets.dart';



// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
// class _HomeScreenState extends State<HomeScreen> {
//   final homeScreenController = Get.put(HomeScreenController());
//   final pdfMergeScreenController = Get.put(PdfMergeScreenController());
//   final ImagePicker imagePicker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           const MainBackgroundWidget(),
//           SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 const HeaderTextModule(),
//                 Container(
//                   height: Get.height * 0.32,
//                   margin: const EdgeInsets.only(left: 10, right: 10),
//                   child: Column(
//                     children: [
//                       Expanded(
//                         flex: 6,
//                         child: Row(
//                           children: [
//                             // Single Image Module
//                             Expanded(
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   // pickSingleImage(context);
//                                   await scanSingleImage();
//                                 },
//                                 child: const PickSingleImageModule(),
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 child: Column(
//                                   children: [
//                                     // Multi Image Module
//                                     Expanded(
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           pickSingleImage(context);
//                                         },
//                                         child: const PickMultiImageModule(),
//                                       ),
//                                     ),
//                                     // Merge PDF Module
//                                     Expanded(
//                                       child: GestureDetector(
//                                         onTap: () async {
//                                           mergePdf(context);
//                                         },
//                                         child: MergePdfModule(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Saved PDF Module
//                       Expanded(
//                         flex: 3,
//                         child: GestureDetector(
//                           onTap: ()=> Get.to(()=> SavedPdfScreen()),
//                           child: const SavedPDfModule(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> scanSingleImage() async {
//     String? imagePath;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // We also handle the message potentially returning null.
//     try {
//       imagePath = (await EdgeDetection.detectEdge);
//       print("$imagePath");
//
//       if(imagePath != null) {
//         homeScreenController.captureImageList.add(File(imagePath));
//         Get.to(() => ImageListScreen());
//       }
//
//     } on PlatformException catch (e) {
//       // imagePath = e.toString();
//       print('PlatformException : $e');
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     // setState(() {
//     //   _imagePath = imagePath;
//     // });
//   }
//
//   pickSingleImage(context) {
//     return showModalBottomSheet<void>(
//       context: context,
//       builder: (BuildContext context) {
//         // we set up a container inside which
//         // we create center column and display text
//         return SizedBox(
//           height: 80,
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 GestureDetector(
//                     onTap: () {
//                       // homeScreenController.selectedGalleryModule.value = 1;
//                       Get.back();
//                       getSingleImageFromGallery();
//                     },
//                     // child: const Icon(Icons.camera)),
//                     child: const Text('Single Image')),
//                 const SizedBox(height: 10),
//                 GestureDetector(
//                     onTap: () {
//                       // homeScreenController.selectedGalleryModule.value = 2;
//                       Get.back();
//                       getMultipleImageFromGallery();
//                     },
//                     // child: const Icon(Icons.collections)),
//                   child: const Text('Multi Image')),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   getSingleImageFromGallery() async {
//     final image = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       // Original File Store In Controller file
//       homeScreenController.file = File(image.path);
//       File imageFile = File(image.path);
//       Get.to(() => CropScreen(imageFile: imageFile));
//     }
//   }
//
//   getMultipleImageFromGallery() async {
//     final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
//     try {
//       if (selectedImages!.isEmpty) {
//       } else if (selectedImages.length == 1) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Please Select Minimum 2 images"),
//         ));
//       } else if (selectedImages.length >= 2) {
//         homeScreenController.captureImageList.clear();
//         for (int i = 0; i < selectedImages.length; i++) {
//           File file = File(selectedImages[i].path);
//           homeScreenController.captureImageList.add(file);
//         }
//         Get.to(() => ImageListScreen());
//       }
//     } catch (e) {
//       print('goToPdfScreen : $e');
//     }
//   }
//
//   // getImageFromCamera() async {
//   //   final image = await imagePicker.pickImage(source: ImageSource.camera);
//   //   if (image != null) {
//   //     // Original File Store In Controller file
//   //     homeScreenController.file = File(image.path);
//   //     File imageFile = File(image.path);
//   //     Get.to(() => CropScreen(imageFile: imageFile));
//   //   }
//   // }
//
//
//   mergePdf(BuildContext context) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//       allowMultiple: true,
//     );
//     if (result != null) {
//       pdfMergeScreenController.files.value = result.paths.map((path) => File(path!)).toList();
//       if (pdfMergeScreenController.files.length > 1) {
//         Get.to(() => PdfMergeScreen());
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text("Please Select 2 PDF")));
//       }
//     }
//   }
// }

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenController = Get.put(HomeScreenController());
  final pdfMergeScreenController = Get.put(PdfMergeScreenController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kLightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25),
                child: CustomHomeScreenAppBar(),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Single Image Module
                        SingleImageModule(),
                        const SizedBox(width: 10),

                        // Merge Pdf Module
                        MergePdfModule(),
                        const SizedBox(width: 10),

                        // Multiple Image Module
                        MultipleImageModule(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SavedPdfModule(),
                  ],
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
