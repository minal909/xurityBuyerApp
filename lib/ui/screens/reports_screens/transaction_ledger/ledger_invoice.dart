import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/models/core/transactional_model.dart';
import 'package:xuriti/ui/screens/reports_screens/transaction_ledger/ledgerInvStateScreen.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../../Model/Inv_Transactionl.dart';
import '../../../../logic/view_models/reward_manager.dart';
import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/core/get_company_list_model.dart';
import '../../../../models/core/reward_model.dart';
import '../../../../models/helper/service_locator.dart';

import '../../../../models/services/dio_service.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/bhome_widgets/bhomeHeading_widget.dart';
import '../../../widgets/bhome_widgets/guide_widget.dart';

class LedgerInvoiceScreen extends StatefulWidget {
  const LedgerInvoiceScreen({Key? key}) : super(key: key);

  @override
  State<LedgerInvoiceScreen> createState() => _LedgerInvoiceScreenState();
}

class _LedgerInvoiceScreenState extends State<LedgerInvoiceScreen> {
  @override
  void dispose() {
    // getIt<TransactionManager>().invoiceDispose();
    super.dispose();
  }

  int currentIndex = 0;
  String? invNo;
  String? sellerName;
  DateTime? transDate;
  String? transAmt;
  TransactionModel? transactionModel;
  TransactionType? transType;

  DateTime? invDate;

  Remark? remark;
  List<dynamic>? txn;
  // final invv
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');
    dynamic responseData =
        await getIt<DioClient>().transactionLedgerNetwork(companyId);
    final transactionData = responseData['transaction'];

    setState(() {
      txn = transactionData;
      this.txn = txn;
    });
  }

  @override
  Widget build(BuildContext context) {
    RewardModel? rewardData = getIt<RewardManager>().rewards;
    GetCompany company = GetCompany();
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

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
      return Scaffold(
          backgroundColor: Colours.black,
          body: ProgressHUD(
              // indicatorWidget: Backlogo(
              //   width: w10p * 2.5,
              //   height: h10p * 2,
              // ),
              child: Builder(builder: (context) {
            String baseUrl = DioClient().baseUrl;
            String dwnld = '/ledger/$companyId/transaction-statement/download';
            String downloadURL = dwnld;
            String url2 = baseUrl + downloadURL;
            Uri uri = Uri.parse(url2);
            final progress = ProgressHUD.of(context);
            return Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 12,
                      top: 80,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: Column(
                                children: [
                                  // SizedBox(
                                  //   width: w10p * 1,
                                  //   height: h10p * 0.6,
                                  //   child: Image.asset(
                                  //       "assets/images/rewardLevel2.png"),
                                  // ),
                                  // const Text(
                                  //   "Level 2",
                                  //   style: TextStyle(color: Colours.white),
                                  // )
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, rewards);
                              },
                            ),
                            Consumer<TransactionManager>(
                                builder: (context, params, child) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 2,
                                  top: 3,
                                ),
                                child: Opacity(
                                    opacity: 0.6000000238418579,
                                    child: Container(
                                      // width: w10p * 3.1,
                                      height: h10p * 0.9,
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
                              // context.showLoader();
                              // progress!.show();
                              Navigator.pushNamed(context, homeCompanyList);
                              // progress.dismiss();
                              // context.hideLoader();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 1, color: Colors.white)
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
                  SizedBox(
                    height: 20,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: txn?.isEmpty ?? true
                        ? Column(
                            children: [
                              SizedBox(
                                height: h1p * 8,
                              ),
                              Center(
                                child: Image.asset(
                                    "assets/images/onboard-image-2.png"),
                              ),
                            ],
                          )
                        : CustomScrollView(
                            slivers: [
                            
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: w10p * 0.6,
                                    vertical: h1p * 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: SvgPicture.asset(
                                                  "assets/images/arrowLeft.svg"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Transactional Statement",
                                            style: TextStyles.textStyleUp,
                                          ),
                                          // Text(
                                          //   "₹ ${outStandingAmt.toStringAsFixed(2)}",
                                          //   style: TextStyles.textStyleUp,
                                          // ),
                                        ],
                                      ),
                                      // InkWell(
                                      //     onTap: () async {},
                                      //     child: Padding(
                                      //       padding: EdgeInsets.only(top: 35),
                                      //       child: Container(
                                      //           height: h1p * 5.3,
                                      //           width: w10p * 1.7,
                                      //           decoration: BoxDecoration(
                                      //               shape: BoxShape.circle,
                                      //               color: Color.fromRGBO(
                                      //                   255, 255, 255, 1),
                                      //               border: Border.all(
                                      //                   width: 2,
                                      //                   color: Colors.green)),
                                      //           child: Icon(
                                      //               Icons.download_rounded,
                                      //               color: Colors.green)),
                                      //     )),

                                      // ))
                                      InkWell(
                                        onTap: () async {
                                          context.showLoader();
                                          String? token =
                                              getIt<SharedPreferences>()
                                                  .getString("token");
                                          dynamic responseData =
                                              await getIt<DioClient>()
                                                  .get(dwnld, token: token);
                                          String url1 = responseData['url'];

                                          Uri uri = Uri.parse(url1);
                                          Future<void> _launchUrl() async {
                                            if (!await launchUrl(uri,
                                                mode: LaunchMode
                                                    .externalApplication)) {
                                              throw Exception(
                                                  'Could not launch $uri');
                                            }
                                          }

                                          if (responseData['status'] == true) {
                                            _launchUrl();
                                          }
                                          context.hideLoader();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 35),
                                          child: Container(
                                            height: h1p * 5.3,
                                            width: w10p * 1.7,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.green)),
                                            child: Icon(Icons.download_rounded,
                                                color: Colors.green),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // SliverToBoxAdapter(
                              //   child: Padding(
                              //       padding: EdgeInsets.symmetric(
                              //           horizontal: w10p * .4),
                              //       child: SubHeadingWidget(
                              //         maxHeight: maxHeight,
                              //         maxWidth: maxWidth,
                              //         heading1: "Upcoming Payments",
                              //       )),
                              // ),
                              txn == null || (txn?.isEmpty ?? true)
                                  ? Container()
                                  : SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                      ((context, index) {
                                        return LedgerInv(
                                          ledgerTransactions: txn ?? [],
                                          transactionAmount: txn![index]
                                                  ['transaction_amount']
                                              .toString(),
                                          invoiceID: txn![index]['invoice_id']
                                              .toString(),
                                          account:
                                              txn![index]['account'].toString(),
                                          createdAt: txn![index]['createdAt']
                                              .toString(),
                                          transactionType: txn![index]
                                                  ['transaction_type']
                                              .toString(),
                                          accountType: txn![index]
                                              ['account_type'],
                                          balance:
                                              txn![index]['balance'].toString(),
                                          counterParty: txn![index]
                                                  ['counter_party']
                                              .toString(),
                                          recordType: txn![index]['record_type']
                                              .toString(),

                                          // currentInvoice: invoice[index],
                                        );
                                      }),
                                      childCount: txn!.length,
                                    )),
                              SliverPadding(
                                padding: EdgeInsets.symmetric(vertical: 18),
                                sliver: SliverToBoxAdapter(
                                    child: GuideWidget(
                                  maxWidth: maxWidth,
                                  maxHeight: maxHeight,
                                )),
                              ),
                              SliverToBoxAdapter(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w10p * .4, vertical: 18),
                                      child: SubHeadingWidget(
                                        maxHeight: maxHeight,
                                        maxWidth: maxWidth,
                                        heading1: "Rewards",
                                      ))),

                              SliverToBoxAdapter(
                                child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    height: 140,
                                    width: maxWidth,
                                    child: Swiper(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Rewards currentReward =
                                            rewardData!.data!.rewards![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 9.0, vertical: 8),
                                          child: Stack(children: [
                                            Container(
                                              margin: const EdgeInsets.all(2),
                                              width: w10p * 9,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(currentReward
                                                                  .status ==
                                                              "CLAIMED"
                                                          ? "assets/images/completed-reward.png"
                                                          : currentReward
                                                                      .status ==
                                                                  "UNCLAIMED"
                                                              ? "assets/images/home_images/bgimage1.png"
                                                              : currentReward
                                                                          .status ==
                                                                      "LOCKED"
                                                                  ? "assets/images/home_images/bgimage2.png"
                                                                  : "assets/images/home_images/bgimage2.png")),
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                  color: Colours.white,
                                                  // border: Border.all(color: Colours.black,width: 0.5),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        spreadRadius: 0.1,
                                                        blurRadius: 1,
                                                        offset: Offset(
                                                          0,
                                                          1,
                                                        )),
                                                    // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
                                                    //     offset: Offset(1,1,))
                                                  ]),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 18),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                                "Xuriti Rewards",
                                                                style: TextStyles
                                                                    .textStyle104),
                                                            Text(
                                                                "Level ${currentReward.level}",
                                                                style: currentReward
                                                                            .status ==
                                                                        "CLAIMED"
                                                                    ? TextStyles
                                                                        .textStyle46
                                                                    : TextStyles
                                                                        .textStyle38),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text("15",
                                                                style: currentReward
                                                                            .status ==
                                                                        "CLAIMED"
                                                                    ? TextStyles
                                                                        .textStyle105
                                                                    : TextStyles
                                                                        .textStyle39),
                                                            Text("/15",
                                                                style: currentReward
                                                                            .status ==
                                                                        "CLAIMED"
                                                                    ? TextStyles
                                                                        .textStyle106
                                                                    : TextStyles
                                                                        .textStyle38),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    currentReward.status ==
                                                            "CLAIMED"
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18.0),
                                                            child:
                                                                LinearPercentIndicator(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            0), //leaner progress bar
                                                                    animation:
                                                                        true,
                                                                    animationDuration:
                                                                        1000,
                                                                    lineHeight:
                                                                        15,
                                                                    percent:
                                                                        100 /
                                                                            100,
                                                                    progressColor:
                                                                        Colours
                                                                            .pumpkin,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey
                                                                            .withOpacity(0.3)),
                                                          )
                                                        : currentReward
                                                                    .status ==
                                                                "UNCLAIMED"
                                                            ? Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        18.0),
                                                                child:
                                                                    LinearPercentIndicator(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                0), //leaner progress bar
                                                                        animation:
                                                                            true,
                                                                        animationDuration:
                                                                            1000,
                                                                        lineHeight:
                                                                            15,
                                                                        percent:
                                                                            50 /
                                                                                100,
                                                                        progressColor:
                                                                            Colours
                                                                                .pumpkin,
                                                                        backgroundColor: Colors
                                                                            .grey
                                                                            .withOpacity(0.3)),
                                                              )
                                                            : currentReward
                                                                        .status ==
                                                                    "LOCKED"
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            18.0),
                                                                    child: LinearPercentIndicator(
                                                                        padding: EdgeInsets.all(0), //leaner progress bar
                                                                        animation: true,
                                                                        animationDuration: 1000,
                                                                        lineHeight: 15,
                                                                        percent: 0 / 100,
                                                                        progressColor: Colours.pumpkin,
                                                                        backgroundColor: Colors.grey.withOpacity(0.3)),
                                                                  )
                                                                : Container(),
                                                    Text(
                                                        currentReward.status ==
                                                                "CLAIMED"
                                                            ? "Level Completed"
                                                            : currentReward
                                                                        .status ==
                                                                    "UNCLAIMED"
                                                                ? "Complete 9 transactions to next reward"
                                                                : currentReward
                                                                            .status ==
                                                                        "LOCKED"
                                                                    ? "Locked 🔒"
                                                                    : "",
                                                        style: currentReward
                                                                    .status ==
                                                                "CLAIMED"
                                                            ? TextStyles
                                                                .textStyle107
                                                            : TextStyles
                                                                .textStyle40)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            currentReward.status == "CLAIMED"
                                                ? Positioned(
                                                    top: h10p * 0.7,
                                                    left: w10p * 2.5,
                                                    child: Container(
                                                      height: h10p * 0.4,
                                                      width: w10p * 2.5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: Colours.pumpkin,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "View Rewards",
                                                          style: TextStyles
                                                              .textStyle47,
                                                        ),
                                                      ),
                                                    ))
                                                : Container(),
                                            currentReward.status == "CLAIMED"
                                                ? Positioned(
                                                    top: h10p * 0.75,
                                                    right: w10p * 0.67,
                                                    child: SvgPicture.asset(
                                                        "assets/images/leading-star.svg"),
                                                  )
                                                : currentReward.status ==
                                                        "UNCLAIMED"
                                                    ? Positioned(
                                                        top: h10p * 0.85,
                                                        right: w10p * 3.4,
                                                        child: SvgPicture.asset(
                                                            "assets/images/leading-star.svg"),
                                                      )
                                                    : currentReward.status ==
                                                            "LOCKED"
                                                        ? Positioned(
                                                            top: h10p * 0.85,
                                                            right: w10p * 3.5,
                                                            child: SvgPicture.asset(
                                                                "assets/images/reward-lockedImage.svg"),
                                                          )
                                                        : Container(),
                                          ]),
                                        );
                                      },
                                      itemCount: 3,
                                      // rewards.data!.rewards!.length,
                                      loop: false,
                                      viewportFraction: 0.8,
                                      scale: 0.99,
                                      onIndexChanged: (value) {
                                        setState(() {
                                          currentIndex = value;
                                        });
                                      },
                                    )),
                              )
                            ],
                          ),
                  ),
                ),
              )
            ]);
          })));
    });
  }
}
