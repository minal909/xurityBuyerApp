import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../theme/constants.dart';

class DocumentUploading extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final bool? flag;
  final Function(List<File?>? files) onFileSelection;
  final bool shouldPickFile;
  //final String type;
  const DocumentUploading(
      {required this.maxWidth,
      required this.maxHeight,
      this.flag,
      required this.onFileSelection,
      this.shouldPickFile = false});

  @override
  State<DocumentUploading> createState() => _DocumentUploadingState();
}

class _DocumentUploadingState extends State<DocumentUploading> {
  File? img;
  String imgpath = '';
  // const uploadfile(
  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;
    double w1p = widget.maxWidth * 0.01;

    // late final img;
    bool isFilesTypeCorrect(List<File?>? fileSelection) {
      List<String> allowedTypes = ['pdf', 'png', 'jpeg', 'xlsx', 'jpg'];
      for (dynamic file in fileSelection!) {
        String str1 = file?.path?.split('?').first;
        String str2 = str1.split('.').last;
        if (!allowedTypes.contains(str2)) {
          return false;
        }
      }
      return true;
    }

    return Padding(
      padding: EdgeInsets.only(left: w1p * 6, right: w1p * 6, top: h1p * 1),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  File? fileSelection =
                      await getIt<KycManager>().getImage(context: context);
                  if (fileSelection != null) {
                    widget.onFileSelection([fileSelection]);
                  }
                },
                child: Container(
                  height: h1p * 6,
                  width: w1p * 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colours.disabledText,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                        "assets/images/kycImages/camera.svg",
                        height: h1p * 4),
                  ),
                ),
              ),
              SizedBox(
                width: w1p * 4,
              ),
              InkWell(
                onTap: () async {
                  List<File?>? fileSelection =
                      await getIt<KycManager>().selectFile(widget.flag);

                  print('=====>File uploaded====>${fileSelection}');
                  if (fileSelection?.isEmpty == true || fileSelection == null) {
                    if (widget.shouldPickFile) {
                      Fluttertoast.showToast(msg: "Please select file");
                    }
                    return;
                  } else if (!isFilesTypeCorrect(fileSelection)) {
                    Fluttertoast.showToast(
                        msg:
                            "Please select file of type- pdf, png, jpeg, xlsx");
                    return;
                  }

                  setState(() {
                    img = fileSelection[0];
                    imgpath = '${img?.path}'; //error
                  });

                 
                  widget.onFileSelection(fileSelection);
                },
                child: Container(
                  height: h1p * 6,
                  width: w10p * 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colours.disabledText,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: w1p * 5, vertical: h1p * 2),
                    child: const Text(
                      "Upload Document",
                      style: TextStyles.textStyle121,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // imgpath.isNotEmpty ? showImage() : const SizedBox()
        ],
      ),
    );
  }

  // Widget showImage() => Padding(
  //     padding: const EdgeInsets.all(8),
  //     child: Center(
  //         child: Column(children: [
  //       ClipRRect(
  //         borderRadius: BorderRadius.circular(8),
  //         child: Image.file(
  //           //to show image, you type like this.
  //           File(imgpath),
  //           fit: BoxFit.cover,
  //           width: MediaQuery.of(context).size.width * 0.5,
  //           height: 200,
  //         ),
  //       ),
  //       Text(
  //         imgpath.split('/').last,
  //         textAlign: TextAlign.center,
  //         overflow: TextOverflow.ellipsis,
  //         // style: const TextStyle(fontWeight: FontWeight.bold),
  //       )
  //     ])));
}
