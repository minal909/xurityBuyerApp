import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/reward_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/get_company_list_model.dart';
import 'package:xuriti/models/core/user_details.dart';

import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../logic/view_models/auth_manager.dart';
import '../../theme/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      GetCompany company = GetCompany();

      UserDetails? userInfo = Provider.of<AuthManager>(context).uInfo;
      int? indexOfCompany = getIt<SharedPreferences>().getInt('companyIndex');
      if (indexOfCompany != null) {
        company = Provider.of<TransactionManager>(context)
            .companyList[indexOfCompany];
      }

      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return Scaffold(
          backgroundColor: Colours.black,
          appBar: AppBar(
            backgroundColor: Colours.black,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset(
                "assets/images/xuriti1.png",
              ),
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.all(18),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                          "assets/images/menubuttonclose.svg"))),
            ],
          ),
          body: ProgressHUD(child: Builder(builder: (context) {
            final progress = ProgressHUD.of(context);
            return Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: w1p * 4, vertical: h1p * 1),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/images/avatar.jpg",
                        ),
                      ),
                      SizedBox(
                        width: w1p * 5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              (userInfo == null || userInfo.user == null)
                                  ? ""
                                  : userInfo.user!.name ?? '',
                              style: TextStyles.textStyle49,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, editProfile);
                                Navigator.pushReplacementNamed(
                                    context, editProfile);
                              },
                              child: const AutoSizeText(
                                " View  Profile",
                                style: TextStyles.textStyle50,
                              ),
                            ),
                            AutoSizeText(
                              (indexOfCompany == null &&
                                      company.companyDetails == null)
                                  ? ""
                                  : company.companyDetails!.companyName ?? '',
                              style: TextStyles.textStyle52,
                            ),
                            AutoSizeText(
                              (userInfo == null ||
                                      userInfo.user == null ||
                                      userInfo.user!.mobileNumber == null)
                                  ? ""
                                  : userInfo.user!.mobileNumber.toString(),
                              style: TextStyles.textStyle52,
                            ),
                            AutoSizeText(
                              (userInfo == null ||
                                      userInfo.user == null ||
                                      userInfo.user!.email == null)
                                  ? ""
                                  : userInfo.user!.email ?? '',
                              style: TextStyles.textStyle52,
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: Container(
                  width: maxWidth,
                  height: maxHeight,
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            width: w10p * 70,
                            height: h10p * 1.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: Colours.offWhite),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/Polygon1.svg"),
                                      const Text(
                                        " You've got",
                                        style: TextStyles.textStyle16,
                                      ),
                                      const Text(
                                        " free credit period",
                                        style: TextStyles.textStyle53,
                                      ),
                                      const Text(
                                        " extension ",
                                        style: TextStyles.textStyle16,
                                      ),
                                      SvgPicture.asset(
                                          "assets/images/Polygon1.svg"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "of",
                                        style: TextStyles.textStyle16,
                                      ),
                                      Text(
                                        " 60 days",
                                        style: TextStyles.textStyle53,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h1p * .5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Complete early invoice payments and enjoy",
                                        style: TextStyles.textStyle48,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "maximum savings and more rewards_screens",
                                        style: TextStyles.textStyle48,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h1p * 0.5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "*applicable only on select sellers",
                                        style: TextStyles.textStyle48,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: w10p * .4, vertical: h1p * 1.8),
                      //   child: Container(
                      //       width: maxWidth,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(16),
                      //           color: Colours.white),
                      //       child: Row(children: [
                      //         Padding(
                      //           padding:
                      //               EdgeInsets.symmetric(horizontal: w10p * .2),
                      //           child:
                      //               SvgPicture.asset("assets/images/logo1.svg"),
                      //         ),
                      //         SizedBox(
                      //           width: w10p * 0.5,
                      //         ),
                      //         // Column(
                      //         //   mainAxisAlignment: MainAxisAlignment.start,
                      //         //   crossAxisAlignment: CrossAxisAlignment.start,
                      //         //   children: [
                      //         //     Padding(
                      //         //       padding: const EdgeInsets.only(top: 10),
                      //         //       child: Column(
                      //         //         children: [
                      //         //           Row(
                      //         //             children: const [
                      //         //               Text(
                      //         //                 "Wohoo",
                      //         //                 style: TextStyles.textStyle20,
                      //         //               ),
                      //         //               Text(
                      //         //                 "!! You have saved ",
                      //         //                 style: TextStyles.textStyle34,
                      //         //               ),
                      //         //               Text(
                      //         //                 "₹ 12,345 ",
                      //         //                 style: TextStyles.textStyle35,
                      //         //               ),
                      //         //               Text(
                      //         //                 "so far..",
                      //         //                 style: TextStyles.textStyle34,
                      //         //               ),
                      //         //             ],
                      //         //           ),
                      //         //         ],
                      //         //       ),
                      //         //     ),
                      //         //     Row(
                      //         //       children: const [
                      //         //         Text(
                      //         //           "Pay more invoices early & save more>>",
                      //         //           style: TextStyles.textStyle34,
                      //         //         )
                      //         //       ],
                      //         //     ),
                      //         //   ],
                      //         // ),
                      //       ])),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(6),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Stack(children: [
                      //         InkWell(
                      //             onTap: () async {
                      //               progress!.show();
                      //               await getIt<RewardManager>().getRewards();
                      //               progress.dismiss();
                      //               Navigator.pushNamed(context, rewards);
                      //             },
                      //             child: Container(
                      //                 height: h1p * 15,
                      //                 width: w10p * 4.5,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius:
                      //                       BorderRadius.circular(8.0),
                      //                   color: Colours.offWhite,
                      //                   //border: Border.all(color: Colours.peach,width: w10p * .23),
                      //                 ),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Image.asset(
                      //                     "assets/images/profile-reward.png",
                      //                     fit: BoxFit.fill,
                      //                   ),
                      //                 ))),
                      //         Positioned(
                      //             bottom: h1p * 2,
                      //             right: w10p * .6,
                      //             child: Text(
                      //               "Rewards",
                      //               style: TextStyles.textStyle103,
                      //             ))
                      //       ]),
                      //       Stack(children: [
                      //         GestureDetector(
                      //             onTap: () {
                      //               Navigator.pushNamed(
                      //                   context, allGuideScreen);
                      //             },
                      //             child: Container(
                      //                 height: h1p * 15,
                      //                 width: w10p * 4.5,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius:
                      //                       BorderRadius.circular(8.0),
                      //                   color: Colours.offWhite,
                      //                   // border: Border.all(color: Colours.peach,width: w10p * .23),
                      //                 ),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Image.asset(
                      //                     "assets/images/profile-guide.png",
                      //                     fit: BoxFit.fill,
                      //                   ),
                      //                 ))),
                      //         Positioned(
                      //             bottom: h1p * 2,
                      //             left: w10p * .6,
                      //             child: Text(
                      //               "Guides",
                      //               style: TextStyles.subHeading,
                      //             ))
                      //       ]),
                      //     ],
                      //   ),
                      // ),
                      const Padding(
                        padding: EdgeInsets.only(left: 24, top: 18),
                        child: Text(
                          "Business Details",
                          style: TextStyles.textStyle43,
                        ),
                      ),
                      SizedBox(
                        height: h1p * 4,
                      ),
                      Card(
                        elevation: 2,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: w1p * 6.5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: h1p * 1,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'Company Name',
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      (indexOfCompany == null ||
                                              company.companyDetails == null)
                                          ? ""
                                          : company.companyDetails!
                                                  .companyName ??
                                              '',
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      'Address',
                                      style: TextStyles.textStyle54,
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        (indexOfCompany == null ||
                                                company.companyDetails == null)
                                            ? ""
                                            : company.companyDetails!.address ??
                                                '',
                                        style: TextStyles.textStyle55,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'PAN No',
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      (indexOfCompany == null ||
                                              company.companyDetails == null)
                                          ? ""
                                          : company.companyDetails!.pan ?? '',
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'District ',
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      (indexOfCompany == null ||
                                              company.companyDetails == null)
                                          ? ""
                                          : company.companyDetails!.district ??
                                              '',
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'State ',
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      (indexOfCompany == null ||
                                              company.companyDetails == null)
                                          ? ""
                                          : company.companyDetails!.state ?? '',
                                      style: TextStyles.textStyle55,
                                    ),
                                    SizedBox(
                                      width: w10p * 1.7,
                                    ),
                                    const AutoSizeText(
                                      'PINCODE ',
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      (indexOfCompany == null ||
                                              company.companyDetails == null ||
                                              company.companyDetails!.pincode ==
                                                  null)
                                          ? ""
                                          : company.companyDetails!.pincode
                                              .toString(),
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * .5,
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      'Type of Business ',
                                      style: TextStyles.textStyle54,
                                    ),
                                    AutoSizeText(
                                      (indexOfCompany == null ||
                                              company.companyDetails == null)
                                          ? ""
                                          : company.companyDetails!.status ??
                                              '',
                                      style: TextStyles.textStyle55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: h1p * 3,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h1p * 6,
                      )
                    ],
                  ),
                ),
              ),
            ]);
          })));
    });
  }
}
