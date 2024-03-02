import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/models/core/invoice_model.dart';
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
import '../../bhome_screens/upcoming_screens/transInvStateScreen.dart';

class TransactionalStatement extends StatefulWidget {
  const TransactionalStatement({Key? key}) : super(key: key);

  @override
  State<TransactionalStatement> createState() => _TransactionalStatementState();
}

class _TransactionalStatementState extends State<TransactionalStatement> {
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

  TransactionType? transType;

  DateTime? invDate;
  bool isPressed = false; // used for download button
  late final Function onClick;
  Remark? remark;
  List<dynamic> trns = [];
  List<TransactionInvoice>? invv = [];
  // final invv
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');
    String? token = await getIt<SharedPreferences>().getString("token");

    //final docs = DioClient().KycDetails(companyId);
    dynamic responseData =
        await getIt<DioClient>().transactionStatementInv(companyId);
    final details = responseData['transcations'];

    setState(() {
      List<dynamic> trns = details;

      this.trns = trns;
      print('transactttt0000000  ${trns[0]['details'][0]['seller_name']}');
      print('transact details fffffff  ${trns[0]['details']}');
    });
  }

  @override
  Widget build(BuildContext context) {
    TransactionInvoice? invv =
        Provider.of<TransactionManager>(context).selectedInvoice;
    // List innvv = invv as List;
    RewardModel? rewardData = getIt<RewardManager>().rewards;
    GetCompany company = GetCompany();
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

    print('copm id +++++++++$companyId');

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
            String dwnld = '/ledger/$companyId/statement/download';
            String downloadURL = dwnld;
            String uurrll = baseUrl + downloadURL;
            Uri uri = Uri.parse(uurrll);
            final progress = ProgressHUD.of(context);

            print('download url trans ++++++++++$uurrll');

            // openFile(
            //     url: baseUrl + downloadURL,
            //     filename:
            //         'transactionLedger.pdf');
            //   /ledger/buyerid/statement/download,

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
                              // onTap: () {
                              //   Navigator.pushNamed(context, rewards);
                              // },
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
                              //progress!.show();
                              context.showLoader();
                              //progress!.show();
                              Navigator.pushNamed(context, homeCompanyList);
                              // progress.dismiss();
                              context.hideLoader();
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
                  Padding(
                      padding: EdgeInsets.only(
                        bottom: h1p * 3,
                        left: w10p * .5,
                      ),
                      child: Container(
                        height: h1p * 9,
                        width: maxWidth,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                context.showLoader();
                                //   progress!.show();
                                context.showLoader();
                                //   progress!.show();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                // progress.dismiss();
                                context.hideLoader();
                                setState(() {
                                  currentIndex = 0;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: w10p * .4),
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: h10p * .2,
                                        bottom: h10p * .17,
                                        right: w10p * 0.65,
                                        left: w10p * .6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: currentIndex == 0
                                            ? Colours.tangerine
                                            : Colours.almostBlack),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                          "assets/images/icon.svg"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: w10p * 0.32,
                                            top: w10p * 0.15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Yearly",
                                              style: TextStyles.textStyle47,
                                            ),
                                            Text(
                                              "Statement",
                                              style: TextStyles.textStyle47,
                                            )
                                          ],
                                        ),
                                      ),
                                    ])),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                context.showLoader();
                                //progress!.show();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                //  progress.dismiss();
                                context.hideLoader();
                                setState(() {
                                  currentIndex = 1;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: w10p * .4),
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: h10p * .2,
                                        bottom: h10p * .17,
                                        right: w10p * 0.65,
                                        left: w10p * .6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: currentIndex == 1
                                            ? Colours.tangerine
                                            : Colours.almostBlack),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                          "assets/images/Icon2.svg"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: w10p * 0.32,
                                            top: w10p * 0.15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Monthly",
                                              style: TextStyles.textStyle47,
                                            ),
                                            Text(
                                              "Statement",
                                              style: TextStyles.textStyle47,
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
                                context.showLoader();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                // progress.dismiss();
                                context.hideLoader();
                                setState(() {
                                  currentIndex = 2;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: w10p * .4),
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: h10p * .2,
                                        bottom: h10p * .17,
                                        right: w10p * 0.65,
                                        left: w10p * .6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: currentIndex == 2
                                            ? Colours.tangerine
                                            : Colours.almostBlack),
                                    child: Row(children: [
                                      SvgPicture.asset(
                                          "assets/images/Icon2.svg"),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: w10p * 0.32,
                                            top: w10p * 0.15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Weekly",
                                              style: TextStyles.textStyle47,
                                            ),
                                            Text(
                                              "Statement",
                                              style: TextStyles.textStyle47,
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
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: trns.isEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                height: h1p * 8,
                              ),
                              Center(
                                child: Image.asset(
                                    "assets/images/onboard-image-2.png"),
                              ),
                              SizedBox(
                                height: h1p * 8,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w10p * .6, vertical: h1p * 1),
                                child: Container(
                                    width: maxWidth,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colours.offWhite),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: h1p * 3,
                                          horizontal: w10p * .3),
                                      child: Row(children: [
                                        SvgPicture.asset(
                                            "assets/images/logo1.svg"),
                                        SizedBox(
                                          width: w10p * 0.5,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Text(
                                                        "Please wait while we connect you with ",
                                                        style: TextStyles
                                                            .textStyle34,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  "your sellers and load your Ledger Report>>",
                                                  style: TextStyles.textStyle34,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    )),
                              ),
                              SizedBox(
                                height: h1p * 8,
                              ),
                            ],
                          )
                        : CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: w10p * 0.6,
                                    vertical: h1p * 3,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: SvgPicture.asset(
                                                      "assets/images/arrowLeft.svg"),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Transactional Ledger",
                                            style: TextStyles.textStyleUp,
                                          ),
                                          // Text(
                                          //   "₹ ${outStandingAmt.toStringAsFixed(2)}",
                                          //   style: TextStyles.textStyleUp,
                                          // ),
                                        ],
                                      ),

                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onHighlightChanged: (param) {
                                          setState(() {
                                            isPressed = param;
                                          });
                                        },
                                        // onTap: () {
                                        //   widget.onClicked();
                                        // },
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

                                          print(
                                              'response data 123**********$uri');
                                          if (responseData['status'] == true) {
                                            _launchUrl();
                                          }
                                          context.hideLoader();
                                          // print(
                                          //     'response data 123**********$uri');
                                          // if (responseData['status'] ==
                                          //     true) {
                                          //   _launchUrl();
                                          // }
                                        },
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
                                                color: Colors.green)),
                                        focusColor: Colors.orange,
                                      ),

                                      // ))
                                    ],
                                  ),
                                ),
                              ),
                              SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                ((context, index) {
                                  return TransInv(
                                    invTransaction: trns[index]['details'],
                                    companyName: trns[index]['details'][0]
                                            ['seller'] ??
                                        ''.toString(),
                                    amount: trns[index]['details'][0]['amount']
                                        .toStringAsFixed(2),
                                    invoiceDate: trns[index]['details'][0]
                                            ['invoice_date']
                                        .toString(),
                                    invoiceNumber:
                                        trns[index]['_id'].toString(),
                                  );
                                }),
                                childCount: trns.length,
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