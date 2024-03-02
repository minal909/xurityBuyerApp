import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../Model/KycDetails.dart';
import '../../../logic/view_models/kyc_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../../models/services/dio_service.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/submitt_button.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  var mobno;
  bool isMobileNoCorrect = true;
  bool isOtpNoCorrect =
      false; //these are validations only for format(only no allowed 4 digits) and not actual correctness of otp
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    var companyId = getIt<SharedPreferences>().getString('companyId');
    print('Mobile- $companyId');
    //final docs = DioClient().KycDetails(companyId);
    dynamic responseData = await getIt<DioClient>().KycDetails(companyId!);
    final details = responseData['data'];
    Mobile Docdetails = Mobile.fromJson(details['mobile']);
    var mobno = Docdetails.number;
    setState(() {
      this.mobno = mobno;
    });
    numberController.text = '${mobno}';
    isMobileNoCorrect = ((int.tryParse(numberController.text) != null &&
            numberController.text.length == 10)) ||
        (numberController.text == '');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
              child: Builder(
                builder: (context) {
                  final progress = ProgressHUD.of(context);
                  return Container(
                    width: maxWidth,
                    decoration: const BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: ListView(
                      children: [
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
                                  "Mobile Verification",
                                  style: TextStyles.leadingText,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: w1p * 6, right: w1p * 6, top: h1p * 3),
                          child: Container(
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: numberController,
                                onChanged: (value) {
                                  value = numberController.text;
                                  setState(() {
                                    isMobileNoCorrect =
                                        ((int.tryParse(numberController.text) !=
                                                    null &&
                                                numberController.text.length ==
                                                    10)) ||
                                            (numberController.text == '');
                                  });
                                  if (isMobileNoCorrect == true &&
                                      numberController.text.length == 10) {
                                    FocusScope.of(context).unfocus();
                                    //init generate otp???
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: w1p * 6, vertical: h1p * .5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: "Mobile Number",
                                  hintStyle: TextStyles.textStyle120,
                                )),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            left: w1p * 6,
                            right: w1p * 6,
                          ),
                          child: isMobileNoCorrect
                              ? Container()
                              : Text('Please enter valid 10 digit Mobile No',
                                  style: TextStyle(color: Colors.redAccent)),
                        ),
                        // SizedBox(
                        //   height: h1p * 3,
                        // ),
                        InkWell(
                          onTap: () async {
                            if (isMobileNoCorrect) {
                              context.showLoader();
                              Map<String, dynamic> kyc =
                                  await getIt<KycManager>()
                                      .generateOTP(numberController.text);
                              context.hideLoader();
                              Fluttertoast.showToast(msg: kyc['msg']);
                            }
                          },
                          child: Submitbutton(
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              content: "Generate OTP",
                              isKyc: true,
                              active: isMobileNoCorrect),
                        ),

                        // SizedBox(
                        //   height: h1p * 3,
                        // ),

                        Padding(
                          padding: EdgeInsets.only(
                              left: w1p * 6, right: w1p * 6, top: h1p * 3),
                          child: Container(
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
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: otpController,
                                onChanged: (value) {
                                  value = otpController.text;
                                  setState(() {
                                    isOtpNoCorrect =
                                        (int.tryParse(otpController.text) !=
                                                null &&
                                            otpController.text.length >= 4 &&
                                            otpController.text.length <= 6);
                                  });
                                  if (isOtpNoCorrect == true &&
                                      otpController.text.length >= 4 &&
                                      otpController.text.length <= 6) {
                                    // FocusScope.of(context).unfocus();
                                    //init generate otp???
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: w1p * 6, vertical: h1p * .5),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: "OTP",
                                  hintStyle: TextStyles.textStyle120,
                                )),
                          ),
                        ),
                        // SizedBox(
                        //   height: h1p * 3,
                        // ),
                        InkWell(
                          onTap: () async {
                            if (isMobileNoCorrect && isOtpNoCorrect) {
                              context.showLoader();
                              Map<String, dynamic> otpDetails =
                                  await getIt<KycManager>()
                                      .verifyOTP(otpController.text);
                              context.hideLoader();
                              Fluttertoast.showToast(msg: otpDetails['msg']);
                              if (otpDetails['error'] == false) {
                                Navigator.pop(context, false);
                              }
                            }
                          },
                          child: Submitbutton(
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                            isKyc: true,
                            content: "Verify OTP",
                            active: isMobileNoCorrect && isOtpNoCorrect,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
