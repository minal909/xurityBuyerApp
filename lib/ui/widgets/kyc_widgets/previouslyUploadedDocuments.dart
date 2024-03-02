import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import '../../theme/constants.dart';

class PreviouslyUploadedDocuments extends StatefulWidget {
  final List<dynamic> imgfiles;
  final BoxConstraints constraints;
  final double maxWidth;
  final double maxHeight;
  final String docHeadingName;

  //final String type;
  const PreviouslyUploadedDocuments({
    required this.imgfiles,
    required this.constraints,
    required this.maxWidth,
    required this.maxHeight,
    required this.docHeadingName,
  });

  @override
  State<PreviouslyUploadedDocuments> createState() =>
      _PreviouslyUploadedDocumentsState();
}

class _PreviouslyUploadedDocumentsState
    extends State<PreviouslyUploadedDocuments> {
  File? img;
  String imgpath = '';
  // const uploadfile(
  @override
  Widget build(BuildContext context) {
    final ScrollController savedDocController = ScrollController();
    double maxHeight = widget.constraints.maxHeight;
    double maxWidth = widget.constraints.maxWidth;
    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;
    double w1p = widget.maxWidth * 0.01;

    // late final img;

    return Padding(
      padding: EdgeInsets.only(
          left: w1p * 6, right: w1p * 6, bottom: w1p * 6, top: w1p * 3
          // top: h1p * 1.5,
          // bottom: h1p * 3
          ),
      child: widget.imgfiles.isEmpty
          ? Container()
          : Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Uploaded Documents',
                    style: TextStyles.leadingText,
                  ),
                  SizedBox(
                    height: w1p,
                  ),
                  SizedBox(
                    width: maxWidth,
                    height: 65,
                    child: Scrollbar(
                      controller: savedDocController,
                      thumbVisibility: true,
                      child: ListView.separated(
                        controller: savedDocController,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.imgfiles.length,
                        itemBuilder: (context, index) {
                          final doc = widget.imgfiles[index];
                          print('the whole filepath  >>>>>>>>$doc');

                          List doc1 = doc.split("?");
                          List doc2 = doc1[0].split(".");
                          List fpath = doc2;
                          print('doc1.>>>>>>>>$doc1');
                          String displayName = doc1[0].split("/").last;
                          print('fpath.>>>>>>>>$fpath');
                          final fp = doc2.last;
                          String filepath = fp.toString();
                          print('filepath from vintage proof>>>>>>>>$filepath');

                          Future<File?> downloadFile(
                              String url, String name) async {
                            final appStorage =
                                await getApplicationDocumentsDirectory();
                            final file = File('${appStorage.path}/$name');
                            try {
                              final response = await Dio().get(url,
                                  options: Options(
                                      responseType: ResponseType.bytes,
                                      followRedirects: false,
                                      receiveTimeout: 0));
                              final raf = file.openSync(mode: FileMode.write);
                              raf.writeFromSync(response.data);
                              await raf.close();
                              return file;
                            } catch (e) {
                              return null;
                            }
                          }

                          Future openFile(
                              {required String url, String? filename}) async {
                            final file = await downloadFile(url, filename!);
                            if (file == null) return;
                            print('path for pdf file++++++++++++ ${file.path}');
                            OpenFile.open(file.path);
                          }

                          // filepath != 'pdf'
                          //     ?
                          if (filepath != 'pdf') {
                            print('object++++====');
                            return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: SizedBox(
                                            width: maxWidth * 5,
                                            height: maxHeight * 0.6,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  displayName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: maxHeight * 0.5,
                                                  child: Image.network(
                                                    '$doc',
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colours.black,
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: w1p * 1,
                                    // right: w1p * 6
                                  ),
                                  child: SizedBox(
                                    width: 70,
                                    child: Column(
                                      children: [
                                        imageDialog(doc),
                                        Text(
                                          displayName,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  openFile(
                                      url: doc,
                                      filename: '${widget.docHeadingName}.pdf');
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: w1p * 1,
                                    // right: w1p * 6
                                  ),
                                  child: SizedBox(
                                    width: 70,
                                    child: Column(
                                      children: [
                                        imageDialog(doc),
                                        Text(
                                          displayName,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          }
                        },
                      ),
                    ),
                    //_checkController();
                  ),
                ],
              ),
            ),
    );
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
    size: 45,
  );
}
