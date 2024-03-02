import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/models/core/seller_list_model.dart';
import 'package:xuriti/ui/screens/paynow_screens/payment_url.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../logic/view_models/company_details_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';

class TotalPayment extends StatefulWidget {
  const TotalPayment({Key? key}) : super(key: key);
  @override
  State<TotalPayment> createState() => _TotalPaymentState();
}

class _TotalPaymentState extends State<TotalPayment> {
  String splashid = '';
  bool checkid = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    prefrences.remove("splashid");
    final checkid = getIt<SharedPreferences>().getBool('checkId');
    this.checkid = checkid!;
    if (checkid == true) {
      // String spd = 'splashid';
      // getIt<SharedPreferences>().setString('splashid', spd);
    }

    // String splashid = 'paynow';
    // getIt<SharedPreferences>().setString('splashid', splashid);
    final PNinvId = getIt<SharedPreferences>().getString('targetid');
  }

  String? companyId;
  String invNo = '';
  String outstandingAmount = '';
  String amountCleared = '';
  String gstSettled = '';
  String discount = '';
  String interest = '';
  String remainingOutstansingAmount = '';

  TextEditingController paidAmountController = TextEditingController();

  // String? _chosenSellerId;
  var items = [''];
  dynamic data = [];
  dynamic notiData = [];

  String outstandingAmount12 = "0.00";

  String interest1 = "0.00";

  String discount1 = "0.00";

  String payable1 = "0.00";

  String revisedDiscount1 = "0.00";

  String revisedInterest1 = "0.00";

  String payablesettlepartpay = "0.00";

  String amountpartpay = "0.00";

  String orderamount = "0.00";
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    getIt<CompanyDetailsManager>().resetSellerInfo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (checkid == true) {
      String? companyId = getIt<SharedPreferences>().getString('entityid');
      setState(() {
        this.companyId = companyId;
      });
    } else {
      String? companyId = getIt<SharedPreferences>().getString('companyId');
      setState(() {
        this.companyId = companyId;
      });
    }

    String? sellerId =
        Provider.of<CompanyDetailsManager>(context).chosenSellerId;
    String settleAmountMsg;
    // = Provider.of<PasswordManager>(context).settleAmountMsg;

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double h30p = maxHeight * 0.5;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return SafeArea(
          child: FutureBuilder(
              future: checkid
                  ? getIt<CompanyDetailsManager>().getSellerList(
                      getIt<SharedPreferences>().getString('entityid'))
                  : getIt<CompanyDetailsManager>().getSellerList(companyId),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<MSeller> sellers = snapshot.data as List<MSeller>;

                  return Scaffold(
                      backgroundColor: Colours.black,
                      appBar: AppBar(
                          elevation: 0,
                          automaticallyImplyLeading: false,
                          toolbarHeight: h10p * .9,
                          flexibleSpace: AppbarWidget()),
                      body: ProgressHUD(child: Builder(builder: (context) {
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
                                      SvgPicture.asset(
                                          "assets/images/arrowLeft.svg"),
                                      SizedBox(
                                        width: w10p * .3,
                                      ),
                                      const Text(
                                        "Pay Now",
                                        style: TextStyles.textStyle127,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w1p * 5, vertical: h1p * 1),
                                child: Text("Seller",
                                    style: TextStyles.textStyle122),
                              ),
                              Consumer<CompanyDetailsManager>(
                                  builder: (context, params, child) {
                                settleAmountMsg = params.settleAmountMsg;
                                String outstandingAmount = "0";
                                String interest = "0";
                                String discount = "0";
                                String paidInterest = "0";
                                String paidDiscount = "0";
                                String payable = "0";

                                if (params.sellerInfo != null) {
                                  String amount = (double.parse(
                                              params.payableAmount ?? '0') -
                                          double.parse(
                                              params.revisedDiscount ?? '0'))
                                      .toStringAsFixed(2);
                                  double amountpart = double.parse(amount);
                                  MoneyFormatter amountpartp =
                                      MoneyFormatter(amount: amountpart);
                                  MoneyFormatterOutput amountpartpa =
                                      amountpartp.output;
                                  amountpartpay =
                                      amountpartpa.nonSymbol.toString();

                                  orderamount =
                                      paidAmountController.text.toString();

                                  print(
                                      "ORDER AMT B________________${orderamount}");

                                  print("AMOUNT+++++++${amountpartpay}");

                                  if (params.sellerInfo!.totalOutstanding !=
                                      null) {
                                    outstandingAmount = double.parse(params
                                            .sellerInfo!.totalOutstanding!)
                                        .toStringAsFixed(2);
                                    double outstdamt =
                                        double.parse(outstandingAmount);
                                    MoneyFormatter outstandingAmo1 =
                                        MoneyFormatter(amount: outstdamt);
                                    MoneyFormatterOutput outstandingAmount1 =
                                        outstandingAmo1.output;
                                    outstandingAmount12 =
                                        outstandingAmount1.nonSymbol.toString();
                                  }
                                  if (params.sellerInfo!.totalInterest !=
                                      null) {
                                    interest = double.parse(
                                            params.sellerInfo!.totalInterest!)
                                        .toStringAsFixed(2);
                                    double intr = double.parse(interest);
                                    MoneyFormatter inter =
                                        MoneyFormatter(amount: intr);
                                    MoneyFormatterOutput inters = inter.output;
                                    interest1 = inters.nonSymbol.toString();
                                  }
                                  if (params.sellerInfo!.totalDiscount !=
                                      null) {
                                    discount = double.parse(
                                            params.sellerInfo!.totalDiscount!)
                                        .toStringAsFixed(2);
                                    double disc = double.parse(discount);
                                    MoneyFormatter disco =
                                        MoneyFormatter(amount: disc);
                                    MoneyFormatterOutput discoun = disco.output;
                                    discount1 = discoun.nonSymbol.toString();

                                    // discount = tempDiscount.round();
                                  }

                                  if (params.sellerInfo!.totalDiscount !=
                                          null &&
                                      (params.sellerInfo!.totalOutstanding !=
                                          null) &&
                                      (params.sellerInfo!.totalInterest !=
                                          null)) {
                                    payable = (double.parse(params.sellerInfo!
                                                .totalOutstanding!) -
                                            double.parse(params
                                                .sellerInfo!.totalDiscount!) +
                                            (double.parse(params
                                                .sellerInfo!.totalInterest!)))
                                        .toStringAsFixed(2);
                                    double pay = double.parse(payable);
                                    MoneyFormatter payb =
                                        MoneyFormatter(amount: pay);
                                    MoneyFormatterOutput payab = payb.output;
                                    payable1 = payab.nonSymbol.toString();
                                  }
                                  if (params.revisedDiscount != null) {
                                    String revisedDiscnt =
                                        params.revisedDiscount.toString();
                                    double revisedDis =
                                        double.parse(revisedDiscnt);
                                    MoneyFormatter revisedDi =
                                        MoneyFormatter(amount: revisedDis);
                                    MoneyFormatterOutput revisedD =
                                        revisedDi.output;
                                    revisedDiscount1 =
                                        revisedD.nonSymbol.toString();
                                    this.revisedDiscount1 == revisedDiscount1;
                                  }
                                  if (params.revisedInterest != null) {
                                    String revisedInt =
                                        params.revisedInterest.toString();
                                    double revisedInte =
                                        double.parse(revisedInt);
                                    MoneyFormatter revisedInter =
                                        MoneyFormatter(amount: revisedInte);
                                    MoneyFormatterOutput revisedIntere =
                                        revisedInter.output;
                                    revisedInterest1 =
                                        revisedIntere.nonSymbol.toString();
                                    this.revisedInterest1 == revisedInterest1;
                                  }
                                }
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w1p * 1,
                                          vertical: h1p * 2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colours.black015,
                                                width: .5),
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      const Color(0x66000000),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 1,
                                                  spreadRadius: 0)
                                            ],
                                            color: Colours.paleGrey,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            value: params.chosenSellerId,
                                            // isExpanded: true,
                                            iconSize: 36,
                                            icon: Padding(
                                              padding: EdgeInsets.only(
                                                  right: w1p * 3),
                                              child: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colours.black,
                                              ),
                                            ),

                                            items:
                                                sellers.map((MSeller seller) {
                                              return DropdownMenuItem(
                                                value: seller.seller!.sId ?? '',
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: w1p * 6),
                                                  child: Text(
                                                    seller.seller!
                                                            .companyName ??
                                                        ' ',
                                                    style:
                                                        TextStyles.textStyle55,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (val) async {
                                              context.showLoader();
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Fetching data please wait");
                                              // setState(() {
                                              //   _chosenSellerId = sellerId;
                                              // });
                                              // progress!.show();

                                              Map<String,
                                                  dynamic>? data = await getIt<
                                                      CompanyDetailsManager>()
                                                  .getSellerInfo(
                                                      companyId, val);
                                              setState(() {
                                                this.data = data;
                                              });

                                              // progress.dismiss();
                                              context.hideLoader();
                                              // print(
                                              //     "inv list ,,,,,,,,,,,,,,,,,${data!["invoiceDetails"][0]['invoice_number']}");
                                              if (data != null &&
                                                  data['msg'] != null) {
                                                Fluttertoast.showToast(
                                                    msg: data['msg']);
                                              }
                                            },
                                            hint: Container(
                                              width: 150, //and here
                                              child: Text(
                                                "Please Select Seller",
                                                style: TextStyles.textStyle128,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: w1p * 5,
                                            vertical: h1p * 1),
                                        child: Container(
                                            height: h10p * 1,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colours.offWhite),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Outstanding Amount",
                                                  style:
                                                      TextStyles.textStyle129,
                                                ),
                                                Text(
                                                  "₹$payable1", // "₹${outstandingAmount.toString()}",
                                                  style: TextStyles.textStyleUp,
                                                )
                                              ],
                                            ))),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: w1p * 5,
                                        ),
                                        child: Container(
                                            height: h10p * 4.5,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: const Color(
                                                          0x66000000),
                                                      offset: Offset(0, 1),
                                                      blurRadius: 1,
                                                      spreadRadius: 0)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colours.white),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: w1p * 7.5,
                                                    vertical: h1p * 0.5),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Discount",
                                                        style: TextStyles
                                                            .textStyle129,
                                                      ),
                                                      Text(
                                                        "Interest",
                                                        style: TextStyles
                                                            .textStyle129,
                                                      ),
                                                      // Text(
                                                      //   "Payable Amount",
                                                      //   style: TextStyles
                                                      //       .textStyle129,
                                                      // )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "₹$discount1",
                                                        style: TextStyles
                                                            .textStyle130,
                                                      ),
                                                      Text(
                                                        "₹$interest1", // "₹${interest.toString()}",
                                                        style: TextStyles
                                                            .textStyle131,
                                                      ),
                                                      // Text(
                                                      //   "₹$payable",
                                                      //   style: TextStyles
                                                      //       .textStyle132,
                                                      // ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Switch(
                                                        value:
                                                            params.isSwitched,
                                                        activeColor:
                                                            Colours.pumpkin,
                                                        inactiveTrackColor:
                                                            Colours.warmGrey,
                                                        onChanged: (_) {
                                                          getIt<CompanyDetailsManager>()
                                                              .toggleSwitch();
                                                          if (params
                                                                  .isSwitched ==
                                                              false) {
                                                            paidAmountController
                                                                .text = "";
                                                          }
                                                          // getIt<CompanyDetailsManager>()
                                                          //     .disablePaynow(true);
                                                        },
                                                      ),
                                                      Text(
                                                        "Settle Your Amount",
                                                        style: TextStyles
                                                            .companyName,
                                                      ),
                                                    ],
                                                  ),
                                                  params.isSwitched == true
                                                      ? Column(children: [
                                                          Container(
                                                            height: h1p * 5,
                                                            decoration:
                                                                BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colours
                                                                        .white,
                                                                    offset:
                                                                        Offset(0,
                                                                            1),
                                                                    blurRadius:
                                                                        1,
                                                                    spreadRadius:
                                                                        0)
                                                              ],
                                                              color:
                                                                  Colours.white,
                                                            ),
                                                            child: Focus(
                                                              onFocusChange:
                                                                  (_) async {
                                                                String
                                                                    settleAmt =
                                                                    paidAmountController
                                                                        .text;
                                                                if (settleAmt
                                                                        .isNotEmpty &&
                                                                    params.isValidateSettleAmount(
                                                                            settleAmt) ==
                                                                        true) {
                                                                  // context
                                                                  //     .showLoader();
                                                                  await getIt<CompanyDetailsManager>().outstandingPayNow(
                                                                      companyId,
                                                                      params
                                                                          .chosenSellerId,
                                                                      paidAmountController
                                                                          .text,
                                                                      isToggled:
                                                                          true);
                                                                  // context
                                                                  //     .hideLoader();
                                                                } else {
                                                                  params
                                                                      .resetRevisedValues();
                                                                  // Fluttertoast
                                                                  //     .showToast(
                                                                  //         msg:
                                                                  //             "Please enter a valid");
                                                                }
                                                              },
                                                              child:
                                                                  TextFormField(
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      onTap:
                                                                          () {
                                                                        params.validateSettleAmount(
                                                                            paidAmountController.text);
                                                                        //  getIt<PasswordManager>().validateSettleAmount(paidAmountController.text);
                                                                      },
                                                                      controller:
                                                                          paidAmountController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding: EdgeInsets.symmetric(
                                                                            horizontal: w1p *
                                                                                6,
                                                                            vertical:
                                                                                h1p * .5),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(6),
                                                                        ),
                                                                        fillColor:
                                                                            Colours.white,
                                                                        hintText:
                                                                            "Enter Amount",
                                                                        hintStyle:
                                                                            TextStyles.textStyle128,
                                                                      )),
                                                            ),
                                                          ),
                                                          settleAmountMsg == ""
                                                              ? Container()
                                                              : Row(
                                                                  children: [
                                                                    Text(
                                                                        settleAmountMsg,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.red)),
                                                                  ],
                                                                ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        w1p * 2,
                                                                    vertical:
                                                                        h1p *
                                                                            2),
                                                            child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        "Discount",
                                                                        style: TextStyles
                                                                            .textStyle129,
                                                                      ),
                                                                      Text(
                                                                        "Interest",
                                                                        style: TextStyles
                                                                            .textStyle129,
                                                                      ),
                                                                      Text(
                                                                        "Settled Amount",
                                                                        style: TextStyles
                                                                            .textStyle129,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        "₹$revisedDiscount1", //${params.revisedDiscount.toString()}",
                                                                        style: TextStyles
                                                                            .textStyle130,
                                                                      ),
                                                                      Text(
                                                                        "₹$revisedInterest1  ", //{params.revisedInterest.toString()}",
                                                                        style: TextStyles
                                                                            .textStyle131,
                                                                      ),
                                                                      Text(
                                                                        "₹$amountpartpay",
                                                                        //"$orderamount",
                                                                        // "₹${(double.parse(params.payableAmount ?? '0') - double.parse(params.revisedDiscount ?? '0')).toStringAsFixed(2)}",
                                                                        style: TextStyles
                                                                            .textStyle132,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ]),
                                                          )
                                                        ])
                                                      : Container(),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                h1p * 2.5),
                                                    child:
                                                        // params.isDisable==true?
                                                        // Container(
                                                        //   height: h1p * 5,
                                                        //   decoration:
                                                        //   BoxDecoration(
                                                        //     borderRadius:
                                                        //     BorderRadius
                                                        //         .circular(6),
                                                        //     color: Colours
                                                        //         .paleGrey,
                                                        //   ),
                                                        //   child: Center(
                                                        //       child: Text(
                                                        //         "Pay Now",
                                                        //         style: TextStyles
                                                        //             .subHeading,
                                                        //       )),
                                                        // ):

                                                        InkWell(
                                                      onTap: () async {
                                                        // if (params.isSwitched ==
                                                        //         true &&
                                                        //     paidAmountController
                                                        //         .text.isEmpty
                                                        //         // &&
                                                        //     // paidAmountController
                                                        //     //     .text
                                                        //         // .isCaseInsensitiveContains(
                                                        //         //     paidAmountController
                                                        //         //         .text)
                                                        //                 ) {
                                                        //   Fluttertoast.showToast(
                                                        //       msg:
                                                        //           'Please enter the amount');
                                                        //   return;
                                                        // }
                                                        if (paidAmountController
                                                                .text
                                                                .isNotEmpty &&
                                                            params.isSwitched ==
                                                                true) {
                                                          progress!.show();

                                                          await getIt<CompanyDetailsManager>().outstandingPayNow(
                                                              companyId,
                                                              params
                                                                  .chosenSellerId,
                                                              paidAmountController
                                                                      .text
                                                                      .isEmpty
                                                                  ? outstandingAmount
                                                                      .toString()
                                                                  : paidAmountController
                                                                      .text);
                                                          progress.dismiss();

                                                          showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder: (
                                                                context,
                                                              ) {
                                                                return Consumer<
                                                                    CompanyDetailsManager>(
                                                                  builder:
                                                                      ((context,
                                                                          value,
                                                                          child) {
                                                                    return AlertDialog(
                                                                      actions: [
                                                                        Center(
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                h1p * 5.5,
                                                                            width:
                                                                                w10p * 2,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5),
                                                                              color: Colours.successPrimary,
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: InkWell(
                                                                                onTap: (() async {
                                                                                  Map<String, dynamic> temResponse = await getIt<CompanyDetailsManager>().outstandingPayNow(companyId, params.chosenSellerId, paidAmountController.text.isEmpty ? outstandingAmount.toString() : paidAmountController.text);
                                                                                  // progress
                                                                                  //     .dismiss();
                                                                                  // progress
                                                                                  //     .show();
                                                                                  if (temResponse.isNotEmpty) {
                                                                                    //show message while redirect payment page
                                                                                    Fluttertoast.showToast(msg: "please wait while you are redirected to make payment");
                                                                                    //progress.show();
                                                                                    context.showLoader();
                                                                                    Map<String, dynamic>? sendPayment = await getIt<CompanyDetailsManager>().sendPayment(
                                                                                      buyerId: companyId,
                                                                                      sellerId: params.chosenSellerId,
                                                                                      orderAmount: ((params.payableAmount.toString() != '0') || paidAmountController.text.toString().isNotEmpty) ? paidAmountController.text.toString() : payable.toString(),
                                                                                      discount: temResponse['revisedDiscount'],
                                                                                      settle_amount: paidAmountController.text.isEmpty ? outstandingAmount.toString() : paidAmountController.text,
                                                                                      outStandingAmount: temResponse['revisedTotalOutstandingAmount'].toString(),
                                                                                    );
                                                                                    context.hideLoader();
                                                                                    //  progress.dismiss();
                                                                                    if (sendPayment != null) {
                                                                                      if (sendPayment['status'] == true) {
                                                                                        // ScaffoldMessenger.of(
                                                                                        //         context)
                                                                                        //     .showSnackBar(
                                                                                        //         SnackBar(
                                                                                        //             behavior:
                                                                                        //                 SnackBarBehavior.floating,
                                                                                        //             content: Text(
                                                                                        //               sendPayment['message'],
                                                                                        //               style: TextStyle(color: Colors.green),
                                                                                        //             )));

                                                                                        // if (sendPayment[
                                                                                        //         'payment_link'] !=
                                                                                        //     null) {
                                                                                        String url = sendPayment['payment_link'];
                                                                                        Navigator.push(
                                                                                            context,
                                                                                            MaterialPageRoute(
                                                                                                builder: (context) => PaymentUrl(
                                                                                                      paymentUrl: url,
                                                                                                    )));
                                                                                      } else {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                            behavior: SnackBarBehavior.floating,
                                                                                            content: Text(
                                                                                              "could not launch the url",
                                                                                              style: TextStyle(color: Colors.red),
                                                                                            )));
                                                                                      }
                                                                                    } else {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                          behavior: SnackBarBehavior.floating,
                                                                                          content: Text(
                                                                                            sendPayment!['message'],
                                                                                            style: TextStyle(color: Colors.green),
                                                                                          )));
                                                                                    }
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(behavior: SnackBarBehavior.floating, content: Text("Please select the seller", style: TextStyle(color: Colors.red))));
                                                                                  }
                                                                                }),
                                                                                child: Text(
                                                                                  "Proceed",
                                                                                  style: TextStyles.textStyle46,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                      content:
                                                                          Container(
                                                                        width: double
                                                                            .maxFinite,
                                                                        child:
                                                                            ListView(
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                IconButton(
                                                                                  icon: Icon(
                                                                                    Icons.close,
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 8.0),
                                                                              child: ListTile(
                                                                                title: Center(child: Text("Payable Amount")),
                                                                                subtitle: Center(
                                                                                  child: Text(
                                                                                    "₹${paidAmountController.text}",
                                                                                    style: TextStyles.textStyle139,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            // ListTile(
                                                                            //     title: Text("Settled Amount"),
                                                                            //     subtitle: value.revisedInterest != 0
                                                                            //         ? Text(
                                                                            //             "₹${(double.parse(value.payableAmount ?? '0') - double.parse(params.revisedInterest ?? '0')).toStringAsFixed(2)}",
                                                                            //             style: TextStyles.textStyle132,
                                                                            //           )
                                                                            //         : Text(
                                                                            //             "₹${(double.parse(value.payableAmount ?? '0') + double.parse(params.revisedDiscount ?? '0')).toStringAsFixed(2)}",
                                                                            //             style: TextStyles.textStyle132,
                                                                            //           )),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              });
                                                        } else {
                                                          // if (params.isSwitched ==
                                                          //         true &&
                                                          //     paidAmountController
                                                          //         .text
                                                          //         .isCaseInsensitiveContains(
                                                          //             paidAmountController
                                                          //                 .text)) {
                                                          //   Fluttertoast.showToast(
                                                          //       msg:
                                                          //           'Please enter the valid number!');
                                                          //   return;
                                                          // }

                                                          context.showLoader();
                                                          //progress!.show();
                                                          Map<String,
                                                              dynamic> temResponse = await getIt<
                                                                  CompanyDetailsManager>()
                                                              .outstandingPayNow(
                                                                  companyId,
                                                                  params
                                                                      .chosenSellerId,
                                                                  paidAmountController
                                                                          .text
                                                                          .isEmpty
                                                                      ? outstandingAmount
                                                                          .toString()
                                                                      : paidAmountController
                                                                          .text
                                                                          .toString());

                                                          context.hideLoader();
                                                          // progress.dismiss();
                                                          if (temResponse
                                                              .isNotEmpty) {
                                                            context
                                                                .showLoader();
                                                            // progress.show();
                                                            Map<String,
                                                                    dynamic>?
                                                                sendPayment =
                                                                await getIt<
                                                                        CompanyDetailsManager>()
                                                                    .sendPayment(
                                                              buyerId:
                                                                  companyId,
                                                              sellerId: params
                                                                  .chosenSellerId,
                                                              orderAmount: ((params
                                                                              .payableAmount
                                                                              .toString() !=
                                                                          '0') ||
                                                                      paidAmountController
                                                                          .text
                                                                          .toString()
                                                                          .isNotEmpty)
                                                                  ? paidAmountController
                                                                      .text
                                                                      .toString()
                                                                  : payable
                                                                      .toString(),
                                                              discount: temResponse[
                                                                  'revisedDiscount'],
                                                              settle_amount: paidAmountController
                                                                      .text
                                                                      .isEmpty
                                                                  ? outstandingAmount
                                                                      .toString()
                                                                  : paidAmountController
                                                                      .text,
                                                              outStandingAmount:
                                                                  temResponse[
                                                                          'revisedTotalOutstandingAmount']
                                                                      .toString(),
                                                            );
                                                            context
                                                                .hideLoader();
                                                            //  progress.dismiss();
                                                            if (sendPayment !=
                                                                null) {
                                                              if (sendPayment[
                                                                      'status'] ==
                                                                  true) {
                                                                // ScaffoldMessenger.of(
                                                                //         context)
                                                                //     .showSnackBar(
                                                                //         SnackBar(
                                                                //             behavior:
                                                                //                 SnackBarBehavior.floating,
                                                                //             content: Text(
                                                                //               sendPayment['message'],
                                                                //               style: TextStyle(color: Colors.green),
                                                                //             )));

                                                                // if (sendPayment[
                                                                //         'payment_link'] !=
                                                                //     null) {
                                                                String url =
                                                                    sendPayment[
                                                                        'payment_link'];
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PaymentUrl(
                                                                              paymentUrl: url,
                                                                            )));
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            content: Text(
                                                                              "could not launch the url",
                                                                              style: TextStyle(color: Colors.red),
                                                                            )));
                                                              }
                                                            }
                                                          }

                                                          // context.showLoader();
                                                          // Map<String,
                                                          //     dynamic> tempResponse = await getIt<
                                                          //         CompanyDetailsManager>()
                                                          //     .outstandingPayNow(
                                                          //         companyId,
                                                          //         params
                                                          //             .chosenSellerId,
                                                          //         paidAmountController
                                                          //                 .text
                                                          //                 .isNotEmpty
                                                          //             ? outstandingAmount
                                                          //                 .toString()
                                                          //             : paidAmountController
                                                          //                 .text);

                                                          // context.hideLoader();
                                                          // // progress.dismiss();
                                                          // if (tempResponse
                                                          //     .isNotEmpty) {
                                                          //   context.showLoader();
                                                          //   // progress.show();
                                                          //   Map<String, dynamic>?
                                                          //       sendPayment =
                                                          //       await getIt<
                                                          //               CompanyDetailsManager>()
                                                          //           .sendPayment(
                                                          //     buyerId: companyId,
                                                          //     sellerId: params
                                                          //         .chosenSellerId,
                                                          //     orderAmount: (paidAmountController
                                                          //                 .text !=
                                                          //             '0')
                                                          //         ? paidAmountController
                                                          //             .text
                                                          //             .toString()
                                                          //         : payable
                                                          //             .toString(),
                                                          //     discount: temResponse[
                                                          //         'revisedDiscount'],
                                                          //     settle_amount: paidAmountController
                                                          //             .text
                                                          //             .isEmpty
                                                          //         ? outstandingAmount
                                                          //             .toString()
                                                          //         : paidAmountController
                                                          //             .text,
                                                          //     outStandingAmount:
                                                          //         tempResponse[
                                                          //                 'revisedTotalOutstandingAmount']
                                                          //             .toString(),
                                                          //   );
                                                          //   context.hideLoader();
                                                          //   //  progress.dismiss();
                                                          //   if (sendPayment !=
                                                          //       null) {
                                                          //     if (sendPayment[
                                                          //             'status'] ==
                                                          //         true) {
                                                          //       // ScaffoldMessenger.of(
                                                          //       //         context)
                                                          //       //     .showSnackBar(
                                                          //       //         SnackBar(
                                                          //       //             behavior:
                                                          //       //                 SnackBarBehavior.floating,
                                                          //       //             content: Text(
                                                          //       //               sendPayment['message'],
                                                          //       //               style: TextStyle(color: Colors.green),
                                                          //       //             )));

                                                          //       // if (sendPayment[
                                                          //       //         'payment_link'] !=
                                                          //       //     null) {
                                                          //       String url =
                                                          //           sendPayment[
                                                          //               'payment_link'];
                                                          //       Navigator.push(
                                                          //           context,
                                                          //           MaterialPageRoute(
                                                          //               builder: (context) =>
                                                          //                   PaymentUrl(
                                                          //                     paymentUrl:
                                                          //                         url,
                                                          //                   )));
                                                          //     } else {
                                                          //       ScaffoldMessenger
                                                          //               .of(
                                                          //                   context)
                                                          //           .showSnackBar(
                                                          //               SnackBar(
                                                          //                   behavior: SnackBarBehavior
                                                          //                       .floating,
                                                          //                   content:
                                                          //                       Text(
                                                          //                     "could not launch the url",
                                                          //                     style:
                                                          //                         TextStyle(color: Colors.red),
                                                          //                   )));
                                                          //     }
                                                          //   }
                                                          // }
                                                          //    else {
                                                          //     ScaffoldMessenger
                                                          //             .of(
                                                          //                 context)
                                                          //         .showSnackBar(
                                                          //             SnackBar(
                                                          //                 behavior: SnackBarBehavior
                                                          //                     .floating,
                                                          //                 content:
                                                          //                     Text(
                                                          //                   sendPayment!['message'],
                                                          //                   style:
                                                          //                       TextStyle(color: Colors.green),
                                                          //                 )));
                                                          //   }
                                                          // } else {
                                                          //   ScaffoldMessenger
                                                          //           .of(context)
                                                          //       .showSnackBar(
                                                          //           SnackBar(
                                                          //               behavior:
                                                          //                   SnackBarBehavior
                                                          //                       .floating,
                                                          //               content:
                                                          //                   Text(
                                                          //                 "Please select the seller",
                                                          //                 style:
                                                          //                     TextStyle(color: Colors.red),
                                                          //               )));
                                                          // }
                                                        }
                                                        //  },
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: InkWell(
                                                              onTap: () async {
                                                                if (params.chosenSellerId ==
                                                                        null &&
                                                                    params.isChecked ==
                                                                        false &&
                                                                    paidAmountController
                                                                        .text
                                                                        .isEmpty) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              new AlertDialog(
                                                                                title: new Text('Payment Summary'),
                                                                                icon: GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.of(context).pop(context);
                                                                                  },
                                                                                  child: Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: Icon(
                                                                                        Icons.close_sharp,
                                                                                        color: Colors.red,
                                                                                      )),
                                                                                ),
                                                                                content: new Container(
                                                                                    width: maxWidth,
                                                                                    height: maxWidth,
                                                                                    decoration: const BoxDecoration(
                                                                                        color: Colours.white,
                                                                                        borderRadius: BorderRadius.only(
                                                                                          topLeft: Radius.circular(26),
                                                                                          topRight: Radius.circular(26),
                                                                                        )),
                                                                                    child: Column(children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: h1p * 4),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: [
                                                                                            const Text("No Invoices Found!", style: TextStyles.textStyle38),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                          padding: EdgeInsets.symmetric(horizontal: w10p * .1, vertical: h1p * 1),
                                                                                          child: Container(
                                                                                            width: maxWidth,
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colours.offWhite),
                                                                                            child: Padding(
                                                                                                padding: EdgeInsets.symmetric(vertical: h1p * .3, horizontal: w10p * .3),
                                                                                                child: Row(children: [
                                                                                                  SvgPicture.asset("assets/images/logo1.svg"),
                                                                                                  SizedBox(
                                                                                                    width: w10p * 0.1,
                                                                                                  ),
                                                                                                  Column(
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Padding(
                                                                                                        padding: const EdgeInsets.only(top: 10),
                                                                                                        child: Column(
                                                                                                          children: [
                                                                                                            Row(
                                                                                                              children: const [
                                                                                                                Text(
                                                                                                                  "Please wait while ",
                                                                                                                  style: TextStyles.textStyle34,
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                            Row(
                                                                                                              children: const [
                                                                                                                Text(
                                                                                                                  " we connect you with",
                                                                                                                  style: TextStyles.textStyle34,
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: const [
                                                                                                          Text(
                                                                                                            "your sellers ",
                                                                                                            style: TextStyles.textStyle34,
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                      Row(
                                                                                                        children: const [
                                                                                                          Text(
                                                                                                            "and load your invoices>>",
                                                                                                            style: TextStyles.textStyle34,
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ])),
                                                                                          )),
                                                                                      SizedBox(
                                                                                        height: h1p * 1,
                                                                                      ),
                                                                                      Center(
                                                                                        child: Image.asset("assets/images/onboard-image-3.png"),
                                                                                      ),
                                                                                    ])),
                                                                                // actions: [
                                                                                //   TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close '))
                                                                                // ],
                                                                              ));
                                                                } else if (params.chosenSellerId !=
                                                                        null &&
                                                                    params.isChecked ==
                                                                        false &&
                                                                    paidAmountController
                                                                        .text
                                                                        .isEmpty) {
                                                                  Map<String,
                                                                      dynamic>? data = await getIt<
                                                                          CompanyDetailsManager>()
                                                                      .getSellerInfo(
                                                                          companyId,
                                                                          sellerId);
                                                                  List
                                                                      datalength =
                                                                      data![
                                                                          "invoiceDetails"];
                                                                  print(
                                                                      "********************${datalength}");
                                                                  setState(() {
                                                                    this.data =
                                                                        data;
                                                                  });
                                                                  // print(
                                                                  //     "inv list ,,,,,,,,,,,,,,,${data["invoiceDetails"][0]['invoice_number']}");

                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              AlertDialog(
                                                                                title: new Text('Payment Summary'),
                                                                                icon: GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.of(context).pop(context);
                                                                                  },
                                                                                  child: Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: Icon(
                                                                                        Icons.close,
                                                                                        color: Colors.red,
                                                                                      )),
                                                                                ),
                                                                                content: Container(
                                                                                  width: maxWidth,
                                                                                  height: h30p,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colours.white,
                                                                                      borderRadius: BorderRadius.only(
                                                                                        topLeft: Radius.circular(26),
                                                                                        topRight: Radius.circular(26),
                                                                                      )),
                                                                                  // child: Column(children: [
                                                                                  // Padding(
                                                                                  // padding: const EdgeInsets.only(
                                                                                  //   left: 15,
                                                                                  //   right: 15,
                                                                                  //   top: 45,
                                                                                  // ),
                                                                                  // child: Flexible(
                                                                                  //   child: SizedBox(
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.symmetric(vertical: h1p * .2, horizontal: w10p * .2),
                                                                                    // padding: const EdgeInsets.only(
                                                                                    //   //left: 6,
                                                                                    //   right: 10,
                                                                                    //   // top: 3,
                                                                                    // ),
                                                                                    child: ListView.builder(
                                                                                        padding: EdgeInsets.zero,
                                                                                        itemCount: datalength.length,
                                                                                        itemBuilder: (context, index) {
                                                                                          print('data lenght ${datalength.length}');
                                                                                          final invNo = datalength[index]['invoice_number'];
                                                                                          print("INV NO : *********************${invNo}");
                                                                                          final outAmt = datalength[index]['outstanding_amount'];
                                                                                          print("OUT AMOU NO : *********************${outAmt}");
                                                                                          String outsAmt = outAmt.toString();
                                                                                          double outstdAmt = double.parse(outsAmt);
                                                                                          MoneyFormatter outStdnAmt = MoneyFormatter(amount: outstdAmt);
                                                                                          MoneyFormatterOutput outStandingAmt = outStdnAmt.output;

                                                                                          final amtclr = datalength[index]['amount_cleared'];
                                                                                          print("Amt Clr : *********************${amtclr}");
                                                                                          String amotclr = amtclr.toString();
                                                                                          double amoutclr = double.parse(amotclr);
                                                                                          MoneyFormatter amountclr = MoneyFormatter(amount: amoutclr);
                                                                                          MoneyFormatterOutput amountCleared = amountclr.output;

                                                                                          final gstSetteled = datalength[index]['gst'];
                                                                                          print("gstSetteled : *********************${gstSetteled}");
                                                                                          String gsts = gstSetteled.toString();
                                                                                          double gstst = double.parse(gsts);
                                                                                          MoneyFormatter gststl = MoneyFormatter(amount: gstst);
                                                                                          MoneyFormatterOutput gstsettled = gststl.output;

                                                                                          final interest = datalength[index]['interest'];
                                                                                          print("interest : *********************${interest}");
                                                                                          String int = interest.toString();
                                                                                          double intr = double.parse(int);
                                                                                          MoneyFormatter intrst = MoneyFormatter(amount: intr);
                                                                                          MoneyFormatterOutput interest1 = intrst.output;

                                                                                          final discunt = datalength[index]['discount'];
                                                                                          print("discount : *********************${discunt}");
                                                                                          String discnt = discunt.toString();
                                                                                          double disnt = double.parse(discnt);
                                                                                          MoneyFormatter dis = MoneyFormatter(amount: disnt);
                                                                                          MoneyFormatterOutput discount = dis.output;

                                                                                          final remainingOut = datalength[index]['remaining_outstanding'];
                                                                                          print("remainingOutstanding : *********************${remainingOut}");
                                                                                          String remainingout = remainingOut.toString();
                                                                                          double remainingamt = double.parse(remainingout);
                                                                                          MoneyFormatter remainingamnt = MoneyFormatter(amount: remainingamt);
                                                                                          MoneyFormatterOutput remainingOutstanding = remainingamnt.output;

                                                                                          return SizedBox(
                                                                                            height: maxHeight * 0.23,
                                                                                            child: Card(
                                                                                                shadowColor: Color.fromARGB(255, 245, 175, 45),
                                                                                                elevation: 5,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(
                                                                                                    left: 7,
                                                                                                    right: 7,
                                                                                                    top: 12,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Column(
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            "Invoice No",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "$invNo",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "Discount",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${discount.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "GST Settled",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${gstsettled.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "Amount Cleared",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${amountCleared.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 2),
                                                                                                        ],
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: w10p * 1,
                                                                                                      ),
                                                                                                      Column(
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            "Outstanding Amount",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${outStandingAmt.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),

                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "Interest",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${interest1.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),

                                                                                                          SizedBox(height: 15),
                                                                                                          Container(
                                                                                                            width: 70,
                                                                                                            height: 45,
                                                                                                            child: Text(
                                                                                                              "Remaining Outstanding Amount",
                                                                                                              style: TextStyle(
                                                                                                                fontSize: 11,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${remainingOutstanding.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          // Flexible(
                                                                                                          //   child:
                                                                                                          // Text(
                                                                                                          //   getNewLineString(),
                                                                                                          //   maxLines: 4,
                                                                                                          //   style: TextStyle(
                                                                                                          //       // leadingDistribution:
                                                                                                          //       //     TextLeadingDistribution
                                                                                                          //       //         .values
                                                                                                          //       //         .last,

                                                                                                          //       // fontSize: 10,
                                                                                                          //       fontWeight: FontWeight.bold),
                                                                                                          // ),

                                                                                                          // Expanded(
                                                                                                          //     child: SizedBox()),
                                                                                                        ],
                                                                                                      ),
                                                                                                      // SizedBox(
                                                                                                      //   width: w10p * 0.2,
                                                                                                      // )
                                                                                                    ],
                                                                                                  ),
                                                                                                )),
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  //   ),
                                                                                  // ),
                                                                                  //   )
                                                                                  // ]),
                                                                                ),
                                                                                // actions: [
                                                                                //   TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close '))
                                                                                // ],
                                                                              ));
                                                                } else if (params
                                                                            .chosenSellerId !=
                                                                        null &&
                                                                    paidAmountController
                                                                        .text
                                                                        .isNotEmpty) {
                                                                  print(
                                                                      "Clicke::::::::::::::::::::::::::::::");
                                                                  Map<String,
                                                                      dynamic>? data1 = await getIt<
                                                                          CompanyDetailsManager>()
                                                                      .getSellerInfoforPartpay(
                                                                          companyId,
                                                                          sellerId,
                                                                          paidAmountController
                                                                              .text);
                                                                  List
                                                                      datalength =
                                                                      data1![
                                                                          "invoiceDetails"];
                                                                  // setState(() {
                                                                  //   this.data =
                                                                  //       data;
                                                                  // });
                                                                  print(
                                                                      "&&&&&&&&&&&&&&&&&&&&&${data1}");
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              new AlertDialog(
                                                                                title: new Text('Payment Summary'),
                                                                                icon: GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.of(context).pop(context);
                                                                                  },
                                                                                  child: Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: Icon(
                                                                                        Icons.close,
                                                                                        color: Colors.red,
                                                                                      )),
                                                                                ),
                                                                                content: new Container(
                                                                                  width: maxWidth,
                                                                                  height: h30p,
                                                                                  decoration: const BoxDecoration(
                                                                                      color: Colours.white,
                                                                                      borderRadius: BorderRadius.only(
                                                                                        topLeft: Radius.circular(26),
                                                                                        topRight: Radius.circular(26),
                                                                                      )),
                                                                                  // child: Column(children: [
                                                                                  // Padding(
                                                                                  // padding: const EdgeInsets.only(
                                                                                  //   left: 15,
                                                                                  //   right: 15,
                                                                                  //   top: 45,
                                                                                  // ),
                                                                                  // child: Flexible(
                                                                                  //   child: SizedBox(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(
                                                                                      //left: 6,
                                                                                      right: 10,
                                                                                      // top: 3,
                                                                                    ),
                                                                                    child: ListView.builder(
                                                                                        padding: EdgeInsets.zero,
                                                                                        itemCount: datalength.length,
                                                                                        itemBuilder: (context, index) {
                                                                                          print('data lenght ${datalength.length}');
                                                                                          final invNo = datalength[index]['invoice_number'];
                                                                                          print("INV NO : *********************${invNo}");
                                                                                          final outAmt = datalength[index]['outstanding_amount'];
                                                                                          print("OUT AMOU NO : *********************${outAmt}");
                                                                                          String outsAmt = outAmt.toString();
                                                                                          double outstdAmt = double.parse(outsAmt);
                                                                                          MoneyFormatter outStdnAmt = MoneyFormatter(amount: outstdAmt);
                                                                                          MoneyFormatterOutput outStandingAmt = outStdnAmt.output;

                                                                                          final amtclr = datalength[index]['amount_cleared'];
                                                                                          print("Amt Clr : *********************${amtclr}");
                                                                                          String amotclr = amtclr.toString();
                                                                                          double amoutclr = double.parse(amotclr);
                                                                                          MoneyFormatter amountclr = MoneyFormatter(amount: amoutclr);
                                                                                          MoneyFormatterOutput amountCleared = amountclr.output;

                                                                                          final gstSetteled = datalength[index]['gst'];
                                                                                          print("gstSetteled : *********************${gstSetteled}");
                                                                                          String gsts = gstSetteled.toString();
                                                                                          double gstst = double.parse(gsts);
                                                                                          MoneyFormatter gststl = MoneyFormatter(amount: gstst);
                                                                                          MoneyFormatterOutput gstsettled = gststl.output;

                                                                                          final interest = datalength[index]['interest'];
                                                                                          print("interest : *********************${interest}");
                                                                                          String int = interest.toString();
                                                                                          double intr = double.parse(int);
                                                                                          MoneyFormatter intrst = MoneyFormatter(amount: intr);
                                                                                          MoneyFormatterOutput interest1 = intrst.output;

                                                                                          final discunt = datalength[index]['discount'];
                                                                                          print("discount : *********************${discunt}");
                                                                                          String discnt = discunt.toString();
                                                                                          double disnt = double.parse(discnt);
                                                                                          MoneyFormatter dis = MoneyFormatter(amount: disnt);
                                                                                          MoneyFormatterOutput discount = dis.output;

                                                                                          final remainingOut = datalength[index]['remaining_outstanding'];
                                                                                          print("remainingOutstanding : *********************${remainingOut}");
                                                                                          String remainingout = remainingOut.toString();
                                                                                          double remainingamt = double.parse(remainingout);
                                                                                          MoneyFormatter remainingamnt = MoneyFormatter(amount: remainingamt);
                                                                                          MoneyFormatterOutput remainingOutstanding = remainingamnt.output;

                                                                                          return SizedBox(
                                                                                            height: maxHeight * 0.28,
                                                                                            child: Card(
                                                                                                shadowColor: Color.fromARGB(255, 245, 175, 45),
                                                                                                elevation: 5,
                                                                                                child: Padding(
                                                                                                  padding: const EdgeInsets.only(
                                                                                                    left: 7,
                                                                                                    right: 7,
                                                                                                    top: 12,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Column(
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            "Invoice No",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "$invNo",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "Discount",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${discount.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "GST Settled",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${gstsettled.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "Amount Cleared",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${amountCleared.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 2),
                                                                                                        ],
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: w10p * 1,
                                                                                                      ),
                                                                                                      Column(
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                        children: [
                                                                                                          Text(
                                                                                                            "Outstanding Amount",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${outStandingAmt.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Text(
                                                                                                            "Interest",
                                                                                                            style: TextStyle(
                                                                                                              fontSize: 11,
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${interest1.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                          SizedBox(height: 15),
                                                                                                          Container(
                                                                                                            width: 70,
                                                                                                            height: 45,
                                                                                                            child: Text(
                                                                                                              "Remaining Outstanding Amount",
                                                                                                              style: TextStyle(
                                                                                                                fontSize: 11,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Text(
                                                                                                            "₹ ${remainingOutstanding.nonSymbol}",
                                                                                                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      // SizedBox(
                                                                                                      //   width: w10p * 0.2,
                                                                                                      // )
                                                                                                    ],
                                                                                                  ),
                                                                                                )),
                                                                                          );
                                                                                        }),
                                                                                  ),
                                                                                  //   ),
                                                                                  // ),
                                                                                  //   )
                                                                                  // ]),
                                                                                ),
                                                                                // actions: [
                                                                                //   TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close '))
                                                                                // ],
                                                                              ));
                                                                }
                                                              },
                                                              child: Text(
                                                                'Payment Summary',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            2,
                                                                            80,
                                                                            143)),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 20),
                                                          Container(
                                                            height: h1p * 5,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              color: Colours
                                                                  .successPrimary,
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                              "PAY NOW",
                                                              style: TextStyles
                                                                  .subHeading,
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ])))),
                                  ],
                                );
                              })
                            ]));
                      })));
                } else {
                  return Center(
                      child: Image.asset(
                          "assets/images/loaderxuriti-unscreen.gif",
                          height: 70
                          // "assets/images/Spinner-3-unscreen.gif",
                          //color: Colors.orange,
                          ));
                }
                // } else {
                //   return Center(
                //       // child: CircularProgressIndicator(
                //       //   color: Colors.white,
                //       child: Image.asset(
                //           "assets/images/loaderxuriti-unscreen.gif",
                //           height: 70
                //           // "assets/images/Spinner-3-unscreen.gif",
                //           //color: Colors.orange,
                //           ));
                // }
              }));
    });
  }
}
