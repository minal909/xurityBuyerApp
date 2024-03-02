import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/previouslyUploadedDocuments.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/selectedImageWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../Model/KycDetails.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../../models/services/dio_service.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/document_uploading.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class BussinessProof extends StatefulWidget {
  const BussinessProof({Key? key}) : super(key: key);

  @override
  State<BussinessProof> createState() => _BussinessProofState();
}

class _BussinessProofState extends State<BussinessProof> {
  TextEditingController documentNoController = TextEditingController();

  List<File?>? businessProofImages;

  String? doc;
  late File business_file;
  var _formKey = GlobalKey<FormState>();
  List imgfiles = [];
  var doctype;
  var docno;
  final ScrollController savedDocController = ScrollController();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    var companyId = getIt<SharedPreferences>().getString('companyId');
    print('Business Proof --- $companyId');
    //final docs = DioClient().KycDetails(companyId);
    dynamic responseData = await getIt<DioClient>().KycDetails(companyId!);
    final details = responseData['data'];
    Business Docdetails = Business.fromJson(details['business']);
    var doc = Docdetails.documentType;
    var docno = Docdetails.documentNumber;
    setState(() {
      List<String> imgfiles = Docdetails.files;
      this.imgfiles = imgfiles;
      this.docno = docno;
      this.doc = doc;
    });
    documentNoController.text = '${docno}';
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
                                  "Business Proof",
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
                              // bottom: h1p * 1,
                              top: h1p * 1),
                          child: Text(
                            "Document Type",
                            style: TextStyles.textStyle122,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              ListTile(
                                title: Row(
                                  children: [
                                    Radio(
                                      value: "GSTN Certificate ",
                                      groupValue: doc,
                                      onChanged: (value) {
                                        setState(() {
                                          doc = value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      "GSTN Certificate",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Radio(
                                      value:
                                          "Utility bill for current business address",
                                      groupValue: doc,
                                      onChanged: (value) {
                                        setState(() {
                                          doc = value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      "Utility bill for current business address",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Radio(
                                      value: "Shop Act",
                                      groupValue: doc,
                                      onChanged: (value) {
                                        setState(() {
                                          doc = value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      "Shop Act",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Radio(
                                      value: "Firm PAN",
                                      groupValue: doc,
                                      onChanged: (value) {
                                        setState(() {
                                          doc = value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      "Firm PAN",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Radio(
                                      value:
                                          "Letter of signatory authorization (for partnership)",
                                      groupValue: doc,
                                      onChanged: (value) {
                                        setState(() {
                                          doc = value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      "Letter of signatory authorization (for partnership)",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Radio(
                                      value: "Udyog Adhar",
                                      groupValue: doc,
                                      onChanged: (value) {
                                        setState(() {
                                          doc = value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      "Udyog Adhar",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    Radio(
                                      value: "Board Resolution (for companies)",
                                      groupValue: doc,
                                      onChanged: (value) {
                                        setState(() {
                                          doc = value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      "Board Resolution (for companies)",
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: w1p * 6,
                                    right: w1p * 6,
                                    top: h1p * 3),
                                child: Container(
                                  //key: _formKey,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0x26000000),
                                          offset: Offset(0, 1),
                                          blurRadius: 1,
                                          spreadRadius: 0)
                                    ],
                                    color: Colours.paleGrey,
                                  ),
                                  child: TextFormField(
                                    controller: documentNoController =
                                        TextEditingController(
                                            text:
                                                '${documentNoController.text}'),
                                    onChanged: (value) {
                                      value = documentNoController.text;
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: w1p * 6,
                                          vertical: h1p * .5),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      fillColor: Colours.paleGrey,
                                      hintText: "Document Number",
                                      hintStyle: TextStyles.textStyle120,
                                    ),
                                    validator: (value1) {
                                      if (value1 == null || value1.isEmpty) {
                                        return 'Enter Valid Number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h1p * 3,
                              ),
                              PreviouslyUploadedDocuments(
                                constraints: constraints,
                                imgfiles: imgfiles,
                                maxHeight: maxHeight,
                                maxWidth: maxWidth,
                                docHeadingName: 'business',
                              ),
                              DocumentUploading(
                                maxWidth: maxWidth,
                                maxHeight: maxHeight,
                                flag: false,
                                shouldPickFile:
                                    businessProofImages?.isEmpty ?? true,
                                onFileSelection: (files) {
                                  businessProofImages = files;
                                  setState(() {});
                                },
                              ),
                              SelectedImageWidget(
                                  documentImages: businessProofImages),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            context.showLoader();
                            Map<String, dynamic> kyc = await getIt<KycManager>()
                                .storeBusinessProof(
                                    documentNoController.text, doc,
                                    filePath:
                                        businessProofImages?.first?.path ?? "");
                            context.hideLoader();
                            Fluttertoast.showToast(msg: kyc['msg']);
                            if (kyc['error'] == false) {
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
