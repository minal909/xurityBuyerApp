import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_safe/open_file_safe.dart';

class SelectedImageWidget extends StatefulWidget {
  final List<File?>? documentImages;

  //final String type;
  const SelectedImageWidget({required this.documentImages});

  @override
  State<SelectedImageWidget> createState() => _SelectedImageWidgetState();
}

class _SelectedImageWidgetState extends State<SelectedImageWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.documentImages == null || widget.documentImages!.isEmpty) {
      return SizedBox();
    } else if (widget.documentImages!.length > 1) {
      return SizedBox(
        height: 220,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            primary: false,
            shrinkWrap: true,
            itemCount: widget.documentImages!.length,
            itemBuilder: (contxt, index) {
              if (widget.documentImages![index]?.path.split('.').last !=
                  'pdf') {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.38,
                  height: 220,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: Image.file(
                              widget.documentImages![index]!,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width * 0.38,
                              height: 190,
                            ),
                          ),
                        ),
                        Text(
                          widget.documentImages![index]?.path.split('/').last ??
                              '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  width: 160,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1),
                            child: GestureDetector(
                              onTap: () {
                                OpenFile.open(
                                    widget.documentImages![index]!.path);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 1,
                                ),
                                child: Icon(Icons.picture_as_pdf, size: 80),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          widget.documentImages![index]?.path.split('/').last ??
                              '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      );
    } else {
      if (widget.documentImages![0]?.path.split('.').last != 'pdf') {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.38,
          height: 220,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child: Image.file(
                      widget.documentImages![0]!,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width * 0.38,
                      height: 190,
                    ),
                  ),
                ),
                Text(
                  widget.documentImages![0]?.path.split('/').last ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      } else {
        return SizedBox(
          width: 160,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child: GestureDetector(
                      onTap: () {
                        OpenFile.open(widget.documentImages![0]!.path);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 1,
                        ),
                        child: Icon(Icons.picture_as_pdf, size: 80),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.documentImages![0]?.path.split('/').last ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
