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

class BankingDetails extends StatefulWidget {
  const BankingDetails({Key? key}) : super(key: key);

  @override
  State<BankingDetails> createState() => _BankingDetailsState();
}

class _BankingDetailsState extends State<BankingDetails> {
  var _formKey = GlobalKey<FormState>();
  final ScrollController savedDocController = ScrollController();
  TextEditingController passwordController = TextEditingController();
  final passwordRegex = RegExp(r'^[a-zA-Z0-9]+(,[a-zA-Z0-9]+)*$');
  String? passwordError;
  List<File?>? bankDetailsImages;
  List imgfiles = [];
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
    Banking Docdetails = Banking.fromJson(details['bankStatement']);
    setState(() {
      List<String> imgfiles = Docdetails.files;
      this.imgfiles = imgfiles;
    });
    // print('business files...))))))))))))${imgfiles[0].toString()}');
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
                                  "Banking Details",
                                  style: TextStyles.leadingText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: w1p * 6,
                              right: w1p * 6,
                              top: h1p * 1.5,
                              bottom: h1p * 3),
                          child: Text(
                            "Bank Statement (Last 6 Months)",
                            style: TextStyles.textStyle123,
                          ),
                        ),
                        PreviouslyUploadedDocuments(
                          constraints: constraints,
                          imgfiles: imgfiles,
                          maxHeight: maxHeight,
                          maxWidth: maxWidth,
                          docHeadingName: 'banking',
                        ),
                        DocumentUploading(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          shouldPickFile: bankDetailsImages?.isEmpty ?? true,
                          onFileSelection: (filesObjects) {
                            if ((bankDetailsImages?.length ?? 0) == 0 &&
                                (filesObjects?.length ?? 0) <= 3) {
                              bankDetailsImages = filesObjects;
                            } else if (((bankDetailsImages?.length ?? 0) +
                                    (filesObjects?.length ?? 0)) <=
                                3) {
                              bankDetailsImages?.addAll(filesObjects!);
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Selection limit for 3 images are accepted");
                            }
                            setState(() {});
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 20),
                          child: Container(
                            // width: 300,
                            // height: 40,
                            child: TextFormField(
                                controller: passwordController,
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  } else if (!passwordRegex.hasMatch(value)) {
                                    return 'Password must be comma-separated list of values';
                                  }
                                  return null;
                                }),
                                onChanged: ((value) {
                                  if (!passwordRegex.hasMatch(value)) {
                                    setState(() {
                                      passwordError =
                                          'Password must be comma-separated';
                                    });
                                  } else {
                                    setState(() {
                                      passwordError = null;
                                    });
                                  }
                                }),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: w1p * 6, vertical: h1p * .5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: "Password",
                                  hintStyle: TextStyles.textStyle120,
                                )),
                          ),
                        ),
                        SelectedImageWidget(documentImages: bankDetailsImages),
                        InkWell(
                          onTap: () async {
                            context.showLoader();
                            Map<String, dynamic> bankingDetails =
                                await getIt<KycManager>().storeBankDetails(
                                    bankStatementImage: bankDetailsImages
                                            ?.map((e) => e?.path ?? "")
                                            .toList() ??
                                        [],
                                    password: passwordController.text);
                            context.hideLoader();
                            Fluttertoast.showToast(msg: bankingDetails['msg']);
                            if (bankingDetails['error'] == false) {
                              Navigator.pop(context, false);
                            }
                          },
                          child: Submitbutton(
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                            content: "Save & Continue",
                            isKyc: true,
                          ),
                        )
                      ]));
                }),
              )));
    });
  }
}

Widget imageDialog(path) {
  return Icon(
    FontAwesome.doc,
    size: 45,
  );
}
