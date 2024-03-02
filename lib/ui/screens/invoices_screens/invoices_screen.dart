import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/get_company_list_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/invoices_screens/cn_invoices/all_cn_invoice.dart';
import 'package:xuriti/ui/screens/invoices_screens/payment_history/payments_history_screen.dart';
import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/pending_invoices_screen.dart';
import 'package:xuriti/ui/screens/reports_screens/transactional_statement_screen/trans_statement_invoice.dart';

import '../../../logic/view_models/auth_manager.dart';
import '../../../models/core/credit_limit_model.dart';
import '../../theme/constants.dart';
import 'all_sellers_screens/all_sellers_screen.dart';
import 'cn_invoices/all_cn_invoice.dart';
import 'pending_invoices_screen/paid_invoices_screen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key, required this.refreshingFunction})
      : super(key: key);

  final Function refreshingFunction;

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  int currentIndex = 0;
  void rebuildHomeScreen() {
    setState(() {
      currentIndex = 4;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? token = await getIt<SharedPreferences>().getString("token");
  }

  @override
  Widget build(BuildContext context) {
    GetCompany company = GetCompany();
    // int? indexOfCompany = getIt<SharedPreferences>().getInt('companyIndex');
    // if (indexOfCompany != null) {
    //   company =
    //       Provider.of<TransactionManager>(context).companyList[indexOfCompany];
    // }

    List<Widget> screens = [
      PInvoices(refreshingFunction: widget.refreshingFunction),
      PaidInvoices(),
      PHistory(),
      AllSellers(),
      //change for refress cnInvoices screen
      CNInvoices(
          refreshingFunction: widget.refreshingFunction,
          rebuildHomeScreen: rebuildHomeScreen),

      //AllSellers(),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return OrientationBuilder(builder: (context, orientation) {
        bool isPortrait = orientation == Orientation.portrait;
        return Scaffold(
            backgroundColor: Colours.black,
            body: ProgressHUD(
              child: Builder(builder: (context) {
                final progress = ProgressHUD.of(context);

                return Column(
                  children: [
                    Container(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    child: Column(
                                      children: [
                                       
                                      ],
                                    ),
                                    
                                  ),
                                  Consumer<TransactionManager>(
                                      builder: (context, params, child) {
                                    return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Opacity(
                                          opacity: 0.6000000238418579,
                                          child: Container(
                                            // width: w10p * 3.1,
                                            height: isPortrait
                                                ? h10p * 0.9
                                                : h10p * 1.8,
                                            // decoration: const BoxDecoration(
                                            //   color: Colours.almostBlack,
                                            // ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: h1p * 1,
                                                ),
                                                const Text(
                                                  "Total Credit Limit / Credit Available",
                                                  style: TextStyles.textStyle21,
                                                ),
                                                SizedBox(
                                                  height: h1p * 0.2,
                                                ),
                                                Text(
                                                  "₹ ${params.selectedCreditLimit} lacs/₹ ${params.availableCredit} lacs",
                                                  style: TextStyles.textStyle22,
                                                ),
                                              ],
                                            ),
                                          )),
                                    );
                                  })
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    progress!.show();
                                    Navigator.pushNamed(
                                        context, homeCompanyList);
                                    progress.dismiss();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 1, color: Colors.white)
                                        //more than 50% of width makes circle
                                        ),
                                    child: Icon(
                                      Icons.business_center,
                                      color: Colours.tangerine,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              bottom: h1p * 3,
                              left: isPortrait ? w10p * .5 : w10p * 0.13,
                            ),
                            child: Container(
                              height: isPortrait ? h1p * 10.005 : h1p * 25.2,
                              width: maxWidth,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      // progress!.show();

                                      // progress.dismiss();
                                      setState(() {
                                        currentIndex = 0;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          // padding: EdgeInsets.symmetric(
                                          //     horizontal: w10p * .6,
                                          //     vertical: h10p * .2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: currentIndex == 0
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                                "assets/images/icon.svg"),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Pending",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  Text(
                                                    "Invoices",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // progress!.show();
                                      Visibility(
                                          visible: true,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Color.fromARGB(
                                                255, 161, 161, 161),
                                          )));
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      Visibility(
                                          visible: false,
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Color.fromARGB(
                                                255, 161, 161, 161),
                                          )));

                                      setState(() {
                                        currentIndex = 1;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: currentIndex == 1
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                                "assets/images/Icon2.svg"),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Paid",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  Text(
                                                    "Invoices",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // progress!.show();

                                      // progress.dismiss();
                                      // context.showLoader();

                                      setState(() {
                                        currentIndex = 2;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: currentIndex == 2
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                                "assets/images/Icon2.svg"),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Payment",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  Text(
                                                    "History",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // context.showLoader();
                                      setState(() {
                                        currentIndex = 3;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: currentIndex == 3
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                                "assets/images/icon3.svg"),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "All",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  Text(
                                                    "Sellers",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // context.showLoader();
                                      setState(() {
                                        currentIndex = 4;
                                      });
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: w10p * .4),
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: h10p * .2,
                                              bottom: h10p * .17,
                                              right: w10p * 0.65,
                                              left: w10p * .6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: currentIndex == 4
                                                  ? Colours.tangerine
                                                  : Colours.almostBlack),
                                          child: Row(children: [
                                            SvgPicture.asset(
                                                //  "assets/images/icon3.svg"
                                                "assets/images/icon.svg"),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w10p * 0.32,
                                                  top: w10p * 0.13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Credit Note",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  ),
                                                  Text(
                                                    "Invoices",
                                                    style:
                                                        TextStyles.textStyle47,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        width: maxWidth,
                        height: maxHeight,
                        // height: h10p*3,
                        decoration: const BoxDecoration(
                            color: Colours.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26),
                            )),
                        child: screens[currentIndex],
                      ),
                    ),
                  ],
                );
              }),
            ));
      });
    });
  }
}


