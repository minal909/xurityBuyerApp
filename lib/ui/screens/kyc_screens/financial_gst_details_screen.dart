import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/kyc_manager.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../Model/KycDetails.dart';
import '../../../models/helper/service_locator.dart';
import '../../../models/services/dio_service.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class FinancialGstDetails extends StatefulWidget {
  const FinancialGstDetails({Key? key}) : super(key: key);

  @override
  State<FinancialGstDetails> createState() => _FinancialGstDetailsState();
}

class _FinancialGstDetailsState extends State<FinancialGstDetails> {
  var _formKey = GlobalKey<FormState>();

  List<File?>? financialImages;
  List<File?>? gstImages;

  bool? flag;

  List financefiles = [];
  List GSTfiles = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

    //final docs = DioClient().KycDetails(companyId);
    dynamic responseData = await getIt<DioClient>().KycDetails(companyId);
    final details = responseData['data'];
    Financial financedetails = Financial.fromJson(details['financial']);
    Gst GSTdetails = Gst.fromJson(details['gst']);
    setState(() {
      List<String> financefiles = financedetails.files;
      this.financefiles = financefiles;
      List<String> GSTfiles = GSTdetails.files;
      this.GSTfiles = GSTfiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return SafeArea(
          child: Scaffold(
              backgroundColor: Colours.black,
              appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: h10p * .9,
                  flexibleSpace: AppbarWidget()),
              body: ProgressHUD(
                child: Builder(builder: (context) {
                  final progress = ProgressHUD.of(context);
                  return Container(
                      width: maxWidth,
                      decoration: const BoxDecoration(
                          color: Colours.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      child: ListView(children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w1p * 3, vertical: h1p * 3),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/arrowLeft.svg"),
                                SizedBox(
                                  width: w10p * .3,
                                ),
                                const Text(
                                  "Financial & GST Details ",
                                  style: TextStyles.leadingText,
                                ),
                                const Text(
                                  "(Upto 24 Months)",
                                  style: TextStyles.textStyle119,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: w1p * 6, right: w1p * 6, top: h1p * 1.5),
                          child: Text(
                            "Financial Details",
                            style: TextStyles.textStyle54,
                          ),
                        ),
                        PreviouslyUploadedDocuments(
                          constraints: constraints,
                          imgfiles: financefiles,
                          maxHeight: maxHeight,
                          maxWidth: maxWidth,
                          docHeadingName: 'finantial',
                        ),
                        DocumentUploading(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          flag: true,
                          shouldPickFile: financialImages?.isEmpty ?? true,
                          onFileSelection: (filesObjects) {
                            if ((financialImages?.length ?? 0) == 0) {
                              financialImages = filesObjects;
                            } else if (((financialImages?.length ?? 0) +
                                    (filesObjects?.length ?? 0)) <=
                                3) {
                              financialImages?.addAll(filesObjects!);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Selection limit for 3 images are accepted");
                            }

                            setState(() {});
                          },
                        ),
                        SelectedImageWidget(documentImages: financialImages),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w1p * 6, vertical: h1p * 3),
                          child: Text(
                            "GST Details",
                            style: TextStyles.textStyle54,
                          ),
                        ),
                        PreviouslyUploadedDocuments(
                          constraints: constraints,
                          imgfiles: GSTfiles,
                          maxHeight: maxHeight,
                          maxWidth: maxWidth,
                          docHeadingName: 'gst',
                        ),
                        DocumentUploading(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          flag: true,
                          shouldPickFile: gstImages?.isEmpty ?? true,
                          onFileSelection: (files) {
                            gstImages = files;
                            setState(() {});
                          },
                        ),
                        SelectedImageWidget(documentImages: gstImages),
                        InkWell(
                          onTap: () async {
                            context.showLoader();
                            Map<String, dynamic> storeGstDetails =
                                await getIt<KycManager>().storeGstDetails(
                              filePath: financialImages
                                      ?.map((e) => e?.path ?? "")
                                      .toList() ??
                                  [],
                              filePath1: gstImages
                                      ?.map((e) => e?.path ?? "")
                                      .toList() ??
                                  [],
                            );
                            context.hideLoader();
                            Fluttertoast.showToast(msg: storeGstDetails['msg']);
                            if (storeGstDetails['error'] == false) {
                              Navigator.pop(context, false);
                            }
                          },
                          child: Submitbutton(
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                            content: "Save & Continue",
                            isKyc: true,
                          ),
                        ),
                      ]));
                }),
              )));
    });
  }
}

Widget imageDialog(path) {
  return Icon( FontAwesome.doc,);
}
