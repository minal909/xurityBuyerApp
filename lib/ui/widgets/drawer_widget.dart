import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../logic/view_models/auth_manager.dart';
import '../../logic/view_models/company_details_manager.dart';
import '../../logic/view_models/profile_manager.dart';
import '../../logic/view_models/transaction_manager.dart';
import '../../models/core/get_company_list_model.dart';
import '../../models/core/user_details.dart';

import '../../models/helper/service_locator.dart';
import '../routes/router.dart';
import '../theme/constants.dart';

class DrawerWidget extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  const DrawerWidget({
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 10);

  dynamic url =
      'https://s3.ap-south-1.amazonaws.com/xuriti.public.document/Xuriti+Terms+of+Service+(002).docx.pdf';
  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    GetCompany company = GetCompany();
    UserDetails? userInfo = Provider.of<AuthManager>(context).uInfo;
    int? indexOfCompany = getIt<SharedPreferences>().getInt('companyIndex');
    String? id = getIt<SharedPreferences>().getString('companyId');

    if (indexOfCompany != null) {
      company =
          Provider.of<TransactionManager>(context).companyList[indexOfCompany];
    }

    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;
    return Drawer(
      backgroundColor: Colours.black,
      child: ListView(
        children: [
          Row(
            children: [
              SizedBox(
                width: w10p * .5,
              ),
              SizedBox(
                height: h10p * 1,
              ),
              Image.asset(
                "assets/images/xuriti-white.png",
                height: h10p * .4,
              ),
            ],
          ),
          SizedBox(
            height: h10p * .1,
          ),
          Container(
            color: Colours.almostBlack,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: h1p * 1.9, horizontal: w10p * .5),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, profile);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1, color: Colors.orange)
                          //more than 50% of width makes circle
                          ),
                      child: CircleAvatar(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.orange,
                        radius: 50,
                        backgroundImage: AssetImage(
                          "assets/images/avatar.jpg",
                        ),
                      ),
                      //  Icon(
                      //   Icons.business_center,
                      //   color: Colours.tangerine,
                      // ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            (indexOfCompany == null ||
                                    company.companyDetails == null)
                                ? ""
                                : company.companyDetails!.companyName ?? '',
                            style: TextStyles.sName,
                          ),
                          Text(
                            (userInfo == null || userInfo.user == null)
                                ? ""
                                : userInfo.user!.name ?? '',
                            style: TextStyles.textStyle21,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                // vertical: h10p * .6,
                //
                horizontal: w10p * .7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () async {
                //     final url = DioClient().launchUrl;
                //     final uri = Uri.parse(url);

                //     launchUrl(uri);
                //   },
                //   child: const Text(
                //     "About Xuriti",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                // SizedBox(height: h1p * 5),
                // InkWell(
                //   onTap: () async {
                //     // context.showLoader();
                //     await getIt<CompanyDetailsManager>().getSellerList(id);
                //     // context.hideLoader();
                //     Navigator.pushNamed(context, totalPayment);
                //   },
                //   child: const Text(
                //     "Pay Now",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, kycVerification);
                  },
                  child: const Text(
                    "KYC Verification",
                    style: TextStyles.textStyle98,
                  ),
                ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, payment_history2);
                //   },
                //   child: const Text(
                //     "Payment History",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                SizedBox(
                  height: h1p * 5,
                ),

                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, transactionalStatement);
                  },
                  child: const Text(
                    "Transaction Ledger",
                    style: TextStyles.textStyle98,
                  ),
                ),
                // SizedBox(
                //   height: h1p * 5,
                // ),

                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, reportsAllSellers);
                //   },
                //   child: const Text(
                //     "Associated Seller",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "Help Center",
                //   style: TextStyles.textStyle98,
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ledgerInvoiceScreen);
                  },
                  child: const Text(
                    "Transaction Statement",
                    style: TextStyles.textStyle98,
                  ),
                ),
                // SizedBox(
                //   height: h1p * 5,
                // ),

                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, reportsAllSellers);
                //   },
                //   child: const Text(
                //     "Associated Seller",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "Help Center",
                //   style: TextStyles.textStyle98,
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () async {
                    Map<String, dynamic> data =
                        await getIt<ProfileManager>().getTermsAndConditions();
                    if (data['status'] == true) {
                      _launchInBrowser(Uri.parse(
                          "https://docs.google.com/gview?embedded=true&url=${data['url']}"));
                      Fluttertoast.showToast(msg: "Opening file");
                    }
                    Fluttertoast.showToast(msg: "Technical error occurred");
                    await getIt<TransactionManager>().openFile(
                        url:
                            "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf");

                    Fluttertoast.showToast(msg: "Opening file");
                  },
                  child: const Text(
                    "Privacy Policy",
                    style: TextStyles.textStyle98,
                  ),
                ),

                // InkWell(
                //   onTap: () async {
                //     Map<String, dynamic> data =
                //         await getIt<ProfileManager>().getTermsAndConditions();
                //     if (data['status'] == true) {
                //       _launchInBrowser(Uri.parse(
                //           "https://docs.google.com/gview?embedded=true&url=${data['url']}"));
                //       Fluttertoast.showToast(msg: "Opening file");
                //     }
                //     Fluttertoast.showToast(msg: "Technical error occurred");
                //     await getIt<TransactionManager>().openFile(
                //         url:
                //             "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf");

                //     Fluttertoast.showToast(msg: "Opening file");

                //     // _launchInWebViewOrVC(Uri.parse(
                //     //     "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf"));
                //     // Map<String, dynamic> data =
                //     //     await getIt<ProfileManager>().getTermsAndConditions();

                //     // _launchInBrowser(Uri.parse(
                //     //     "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/Xuriti+Terms+of+Service+(002).docx.pdf"));
                //     // Fluttertoast.showToast(msg: "Opening file");

                //     // Fluttertoast.showToast(msg: "Technical error occurred");
                //     //     const url =
                //     //         'https://s3.ap-south-1.amazonaws.com/xuriti.public.document/Xuriti+Terms+of+Service+(002).docx.pdf';

                //     // dynamic uri =  Uri.parse(url);
                //     //     if (await canLaunchUrl(uri )) {
                //     //       await launchUrl(Uri.parse(
                //     //         url,
                //     //       ));

                //     //       Fluttertoast.showToast(msg: "Opening file");
                //     //     } else {
                //     //       Fluttertoast.showToast(msg: "Technical error occurred");
                //     //     }
                //   },
                //   child: const Text(
                //     "Terms of Use",
                //     style: TextStyles.textStyle98,
                //   ),
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "FAQs",
                //   style: TextStyles.textStyle98,
                // ),
                // SizedBox(
                //   height: h1p * 5,
                // ),
                // const Text(
                //   "FAQs",
                //   style: TextStyles.textStyle98,
                // ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () async {
                    final url = DioClient().contactUrl;
                    final uri = Uri.parse(url);

                    launchUrl(uri);
                  },
                  child: const Text(
                    "Contact Us",
                    style: TextStyles.textStyle98,
                  ),
                ),
                SizedBox(
                  height: h1p * 5,
                ),
                InkWell(
                  onTap: () async {
                    final url = DioClient().launchUrl;
                    final uri = Uri.parse(url);

                    launchUrl(uri);
                  },
                  child: const Text(
                    "About Xuriti",
                    style: TextStyles.textStyle98,
                  ),
                ),
                SizedBox(
                  height: h1p * 5,
                ),

                InkWell(
                  onTap: () async {
                    await getIt<AuthManager>().logOut();
                    await getIt<SharedPreferences>().clear();
                    await getIt<SharedPreferences>()
                        .setString('onboardViewed', 'true');

                    Navigator.pushNamed(context, getStarted);
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyles.textStyle98,
                  ),
                ),
                SizedBox(
                  height: h1p * 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
