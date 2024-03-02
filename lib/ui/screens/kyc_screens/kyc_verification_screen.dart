import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/Model/KycDetails.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/ui/screens/kyc_screens/aadhaar_card_screen.dart';

import '../../../logic/view_models/kyc_manager.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/get_company_list_model.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/kyc_widgets/kyc_details.dart';

class KycVerification extends StatefulWidget {
  const KycVerification({Key? key}) : super(key: key);

  @override
  State<KycVerification> createState() => _KycVerificationState();
}

class _KycVerificationState extends State<KycVerification> {
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  double currentIndexPage = 1;
  dynamic details;
  int pageLength = 2;
  KycStatus? kycStatus;
  var companyId = '';

  // @override
  // void initState() {
  //   _controller.addListener(() {
  //     setState(() {
  //       currentIndexPage = _controller as double;
  //     });
  //   });
  //   super.initState();
  // }
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    bool? checkid = getIt<SharedPreferences>().getBool('checkId');
    if (checkid == true) {
      var companyId = getIt<SharedPreferences>().getString('entityid');
    } else {
      var companyId = getIt<SharedPreferences>().getString('companyId');
    }
    dynamic responseData = await getIt<DioClient>().KycDetails(companyId);
    details = responseData?['data'] ?? <String, dynamic>{};

    setState(() {
      kycStatus = KycStatus.fromJson(details);
      this.companyId = companyId;
    });

    print(kycStatus?.toJson());
  }

  @override
  Widget build(BuildContext context) {
    GetCompany company = GetCompany();
    int? indexOfCompany = getIt<SharedPreferences>().getInt('companyIndex');
    if (indexOfCompany != null) {
      company =
          Provider.of<TransactionManager>(context).companyList[indexOfCompany];
    }
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
                    child: ListView(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w1p * 4, vertical: h1p * 3),
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/arrowLeft.svg"),
                                SizedBox(
                                  width: w10p * .3,
                                ),
                                const Text(
                                  "KYC Verification",
                                  style: TextStyles.leadingText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: w1p * 2,
                          ),
                          child: Container(
                            height: h10p * 1.1,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0x66000000),
                                    offset: Offset(0, 1),
                                    blurRadius: 1,
                                    spreadRadius: 0)
                              ],
                              borderRadius: BorderRadius.circular(16),
                              color: Colours.offWhite,
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w1p * 3),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/logo1.svg"),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: w1p * 3),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              (indexOfCompany == null &&
                                                      company.companyDetails ==
                                                          null)
                                                  ? ""
                                                  : company.companyDetails!
                                                          .companyName ??
                                                      '',
                                              style: TextStyles.textStyle116,
                                            ),
                                            Text(
                                              " Submit the",
                                              style: TextStyles.textStyle117,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "following documents to complete your KYC",
                                          style: TextStyles.textStyle117,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: w1p * 3, top: h1p * 4, right: w1p * 3),
                          child: InkWell(
                            onTap: () async {
                              dynamic err = await Navigator.pushNamed(
                                  context, panDetails);

                              // var companyId = getIt<SharedPreferences>()
                              //     .getString('companyId');
                              // dynamic responseData = await getIt<DioClient>()
                              //     .KycDetails(companyId!);
                              if (err.runtimeType == bool) {
                                setState(() {
                                  details?['pan']?['verified'] =
                                      err ? false : true;
                                  // kycStatus = KycStatus.fromJson(details);//should be converted to inprogress
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                        color: const Color(0x1f000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 1,
                                        spreadRadius: 0)
                                  ],
                                  color: Colours.white),
                              child: ListTile(
                                tileColor: Colours.white,
                                title: Row(
                                  children: [
                                    // KycStatus.kycStatusToIcon(//////
                                    //     kycStatus?.panStatus),
                                    ///
                                    ///

                                    details?['pan']?['verified'] ?? false
                                        ? const Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.green,
                                          )
                                        : const Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),

                                    SizedBox(
                                      width: w1p * 3,
                                    ),
                                    Text(
                                      "PAN Verification ",
                                      style: TextStyles.textStyle44,
                                    ),
                                    Text(
                                      "* ",
                                      style: TextStyles.textStyle118,
                                    ),
                                    // Text(
                                    //   "(Individual)",
                                    //   style: TextStyles.textStyle119,
                                    // ),
                                  ],
                                ),
                                trailing: SvgPicture.asset(
                                    "assets/images/kycImages/vector.svg"),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var data = await getIt<KycManager>().getCaptcha();
                            //  print("Data : $data");
                            // AdhaarController.adhaarDetails(companyId, , back)
                            // Fluttertoast.showToast(
                            //     msg: "successfully uploaded");
                            dynamic err = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (__) => AadhaarCard(data)));
                            // Navigator.pushNamed(
                            //   context,
                            //   aadhaarCard,
                            // );

                            // var companyId = getIt<SharedPreferences>()
                            //     .getString('companyId');
                            // dynamic responseData =
                            //     await getIt<DioClient>().KycDetails(companyId!);
                            if (err.runtimeType == bool) {
                              setState(() {
                                details?['aadhar']?['verified'] =
                                    err ? false : true;
                                // kycStatus = KycStatus.fromJson(details);
                              });
                            }
                          },

                          // onTap: () {
                          //   Navigator.pushNamed(context, aadhaarCard);
                          // },
                          child: KycDetails(
                              title: "AADHAAR Verification",
                              //subtitle: " (Any one of the following)",
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              // kycStatus: kycStatus?.aadharStatus,
                              kycStatus:
                                  details?['aadhar']?['verified'] ?? false),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: w1p * 3, top: h1p * 4, right: w1p * 3),
                        //   child:
                        InkWell(
                          onTap: () async {
                            dynamic err = await Navigator.pushNamed(
                                context, mobileVerification);
                            // var companyId = getIt<SharedPreferences>()
                            //     .getString('companyId');
                            // dynamic responseData =
                            //     await getIt<DioClient>().KycDetails(companyId!);
                            if (err.runtimeType == bool) {
                              setState(() {
                                details?['mobile']?['verified'] =
                                    err ? false : true;
                                // kycStatus = KycStatus.fromJson(details);
                              });
                            }
                          },
                          child: KycDetails(
                              title: "Mobile Verification",
                              //  subtitle: " (Any one of the following)",
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              isMandatory: true,
                              kycStatus:
                                  details?['mobile']?['verified'] ?? false),
                        ),
                        SizedBox(
                          height: h1p * 3,
                        ),
                        //  PageIndicator(count: 2, controller: PageController()),
                        // DotsIndicator(
                        //   dotsCount: pageLength,
                        //   position: currentIndexPage,
                        //   decorator: DotsDecorator(
                        //     color: Colors.black87, // Inactive color
                        //     activeColor: Color.fromARGB(255, 45, 128, 236),
                        //   ),
                        // ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: w1p * 3, right: w1p * 3),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, kycnextstep);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'NEXT',
                                  style: TextStyles.textStyle44,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ),

                        // SizedBox(
                        //   height: h1p * 10,
                        // ),
                      ],
                    ),
                  );
                }),
              )));
    });
  }
}

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:xuriti/models/helper/service_locator.dart';
// import 'package:xuriti/ui/screens/starting_screens/company_list.dart';

// import '../../../logic/view_models/kyc_manager.dart';
// import '../../../logic/view_models/transaction_manager.dart';
// import '../../../models/core/get_company_list_model.dart';
// import '../../routes/router.dart';
// import '../../theme/constants.dart';
// import '../../widgets/appbar/app_bar_widget.dart';
// import '../../widgets/kyc_widgets/kyc_details.dart';

// class KycVerification extends StatefulWidget {
//   const KycVerification({Key? key}) : super(key: key);

//   @override
//   State<KycVerification> createState() => _KycVerificationState();
// }

// class _KycVerificationState extends State<KycVerification> {
//   @override
//   Widget build(BuildContext context) {
//     GetCompany company = GetCompany();
//     int? indexOfCompany = getIt<SharedPreferences>().getInt('companyIndex');
//     if (indexOfCompany != null) {
//       company =
//           Provider.of<TransactionManager>(context).companyList[indexOfCompany];
//     }
//     return LayoutBuilder(builder: (context, constraints) {
//       double maxHeight = constraints.maxHeight;
//       double maxWidth = constraints.maxWidth;
//       double h1p = maxHeight * 0.01;
//       double h10p = maxHeight * 0.1;
//       double w10p = maxWidth * 0.1;
//       double w1p = maxWidth * 0.01;
//       return SafeArea(
//           child: Scaffold(
//               backgroundColor: Colours.black,
//               appBar: AppBar(
//                   elevation: 0,
//                   automaticallyImplyLeading: false,
//                   toolbarHeight: h10p * .9,
//                   flexibleSpace: AppbarWidget()),
//               body: ProgressHUD(
//                 child: Builder(builder: (context) {
//                   final progress = ProgressHUD.of(context);
//                   return Container(
//                     width: maxWidth,
//                     decoration: const BoxDecoration(
//                         color: Colours.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(10),
//                           topRight: Radius.circular(10),
//                         )),
//                     child: ListView(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                             Navigator.of(context).push(new MaterialPageRoute(
//                                 builder: (context) => CompanyList()));
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: w1p * 4, vertical: h1p * 3),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset("assets/images/arrowLeft.svg"),
//                                 SizedBox(
//                                   width: w10p * .3,
//                                 ),
//                                 const Text(
//                                   "KYC Verification",
//                                   style: TextStyles.leadingText,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: w1p * 2,
//                           ),
//                           child: Container(
//                             height: h10p * 1.1,
//                             decoration: BoxDecoration(
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: const Color(0x66000000),
//                                     offset: Offset(0, 1),
//                                     blurRadius: 1,
//                                     spreadRadius: 0)
//                               ],
//                               borderRadius: BorderRadius.circular(16),
//                               color: Colours.offWhite,
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.symmetric(horizontal: w1p * 5),
//                               child: Row(
//                                 children: [
//                                   SvgPicture.asset("assets/images/logo1.svg"),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: w1p * 3),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             AutoSizeText(
//                                               (indexOfCompany == null &&
//                                                       company.companyDetails ==
//                                                           null)
//                                                   ? ""
//                                                   : company.companyDetails!
//                                                           .companyName ??
//                                                       '',
//                                               style: TextStyles.textStyle116,
//                                             ),
//                                             Text(
//                                               " Submit the",
//                                               style: TextStyles.textStyle117,
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "following documents to complete your KYC",
//                                           style: TextStyles.textStyle117,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Padding(
//                         //   padding:
//                         //       EdgeInsets.only(left: w1p * 3, right: w1p * 3),
//                         //   child: InkWell(
//                         //     // onTap: () {
//                         //     //   Navigator.pushNamed(context, panDetails);
//                         //     // },
//                         //     child: Container(
//                         //       decoration: BoxDecoration(
//                         //           borderRadius: BorderRadius.circular(16),
//                         //           boxShadow: [
//                         //             BoxShadow(
//                         //                 color: const Color(0x1f000000),
//                         //                 offset: Offset(0, 3),
//                         //                 blurRadius: 1,
//                         //                 spreadRadius: 0)
//                         //           ],
//                         //           color: Colours.white),
//                         //       // child: ListTile(
//                         //       //   tileColor: Colours.white,
//                         //       //   title: Row(
//                         //       //     children: [
//                         //       //       Text(
//                         //       //         "PAN Details ",
//                         //       //         style: TextStyles.textStyle44,
//                         //       //       ),
//                         //       //       Text(
//                         //       //         "* ",
//                         //       //         style: TextStyles.textStyle118,
//                         //       //       ),
//                         //       //       Text(
//                         //       //         "(Individual)",
//                         //       //         style: TextStyles.textStyle119,
//                         //       //       ),
//                         //       //     ],
//                         //       //   ),
//                         //       //   trailing: SvgPicture.asset(
//                         //       //       "assets/images/kycImages/vector.svg"),
//                         //       // ),
//                         //     ),
//                         //   ),
//                         // ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context, addressProof);
//                           },
//                           child: KycDetails(
//                             title: "Address Proof",
//                             subtitle: " (Any one of the following)",
//                             maxHeight: maxHeight,
//                             maxWidth: maxWidth,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context, businessProof);
//                           },
//                           child: KycDetails(
//                             title: "Business Proof",
//                             subtitle: " (Any one of the following)",
//                             maxHeight: maxHeight,
//                             maxWidth: maxWidth,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context, ownershipProof);
//                           },
//                           child: KycDetails(
//                             title: "Ownership Proof",
//                             subtitle:
//                                 " (Business/Residence) (Any one of the following)",
//                             maxHeight: maxHeight,
//                             maxWidth: maxWidth,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context, vintageProof);
//                           },
//                           child: KycDetails(
//                             title: "Vintage Proof",
//                             maxHeight: maxHeight,
//                             maxWidth: maxWidth,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context, firmDetails);
//                           },
//                           child: KycDetails(
//                             title: "Firm/Partnership Details",
//                             maxHeight: maxHeight,
//                             maxWidth: maxWidth,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Navigator.pushNamed(context, bankDetails);
//                           },
//                           child: KycDetails(
//                             title: "Banking Details",
//                             maxHeight: maxHeight,
//                             maxWidth: maxWidth,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: w1p * 3, top: h1p * 4, right: w1p * 3),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pushNamed(context, finGstDetails);
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(16),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: const Color(0x1f000000),
//                                         offset: Offset(0, 3),
//                                         blurRadius: 1,
//                                         spreadRadius: 0)
//                                   ],
//                                   color: Colours.white),
//                               child: ListTile(
//                                 tileColor: Colours.white,
//                                 title: Row(
//                                   children: [
//                                     Text(
//                                       "Financial & GST Details ",
//                                       style: TextStyles.textStyle44,
//                                     ),
//                                     Text(
//                                       "(Upto 24 Months)",
//                                       style: TextStyles.textStyle119,
//                                     ),
//                                   ],
//                                 ),
//                                 trailing: SvgPicture.asset(
//                                     "assets/images/kycImages/vector.svg"),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: h1p * 3,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: w1p * 5,
//                           ),
//                           child: InkWell(
//                             onTap: () async {
//                               progress!.show();
//                               Map<String, dynamic> kyc =
//                                   await getIt<KycManager>().getKycSubmission();
//                               progress.dismiss();
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(SnackBar(
//                                       behavior: SnackBarBehavior.floating,
//                                       content: Text(
//                                         kyc['msg'],
//                                         style: TextStyle(
//                                             color: kyc['status'] == true
//                                                 ? Colors.green
//                                                 : Colors.green),
//                                       )));
//                               Navigator.pop(context);
//                             },
//                             child: Container(
//                               height: h1p * 6,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 color: Colours.tangerine,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   "Submit Details",
//                                   style: TextStyles.subHeading,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: h1p * 10,
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//               )));
//     });
//   }
// }
