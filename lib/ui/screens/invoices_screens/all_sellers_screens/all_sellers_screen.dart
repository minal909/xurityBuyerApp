import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/invoice_model.dart';

import '../../../../models/helper/service_locator.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/company_details.dart';

class AllSellers extends StatefulWidget {
  @override
  State<AllSellers> createState() => _AllSellersState();
}

class _AllSellersState extends State<AllSellers> {
  @override
  Widget build(BuildContext context) {
    Invoice? invoice = Provider.of<TransactionManager>(context).currentInvoice;
    String? companyId = getIt<SharedPreferences>().getString('companyId');

    List<Widget> screens = [];
    return ProgressHUD(
        child: Material(child: LayoutBuilder(builder: (context, constraints) {
      final progress = ProgressHUD.of(context);
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return Scaffold(
          backgroundColor: Colors.black,
          body: Column(children: [
            // SizedBox(
            //   height: h10p * .3,
            // ),
            Expanded(
                child: Container(
                    width: maxWidth,
                    decoration: const BoxDecoration(
                        color: Colours.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26),
                        )),
                    child: invoice != null
                        ? ListView(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 13),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w10p * .3,
                                  ),
                                  const Text("All Sellers",
                                      style: TextStyles.textStyle38),
                                ],
                              ),
                            ),
                            AllSellersWidget(
                              maxHeight: maxHeight,
                              maxWidth: maxWidth,
                              image: "assets/images/company-vector.png",
                              companyName: invoice.seller?.companyName ?? '',
                              companyAddress: invoice.seller?.address ?? '',
                              state: invoice.seller?.state ?? '',
                              gstNo: invoice.seller?.gstin ?? '',
                              creditLimit: invoice.buyer?.creditLimit ?? '',
                              balanceCredit: invoice.buyer?.availCredit ?? '',
                            ),
                            SizedBox(height: h1p * 2),
                          ])
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: h1p * 4, horizontal: w10p * .3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("All Sellers",
                                        style: TextStyles.textStyle38),
                                    // Row(
                                    //   children: [
                                    //     Text(
                                    //       "Filters     ",
                                    //       style: TextStyles.textStyle38,
                                    //     ),
                                    //     SvgPicture.asset("assets/images/filterRight.svg"),
                                    //   ],
                                    // )
                                  ],
                                ),
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
                                          vertical: h1p * 4,
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
                                                        "No seller available",
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
                                                  "",
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
                              Center(
                                child: Image.asset(
                                    "assets/images/onboard-image-3.png"),
                              ),
                            ],
                          )))
          ]));
    })));
  }
}

class AllSellersWidget extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final String companyName;
  final String image;
  final String companyAddress;
  final String state;
  final String gstNo;
  final String creditLimit;
  final String balanceCredit;

  const AllSellersWidget({
    required this.maxWidth,
    required this.maxHeight,
    required this.image,
    required this.companyName,
    required this.companyAddress,
    required this.state,
    required this.gstNo,
    required this.creditLimit,
    required this.balanceCredit,
  });

  @override
  State<AllSellersWidget> createState() => _AllSellersWidgetState();
}

class _AllSellersWidgetState extends State<AllSellersWidget> {
  @override
  Widget build(BuildContext context) {
    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;
    Invoice? invoice = Provider.of<TransactionManager>(context).currentInvoice;
    double cl =
        (widget.creditLimit.isNotEmpty) ? double.parse(widget.creditLimit) : 0;

    double bc = (widget.balanceCredit.isNotEmpty)
        ? double.parse(widget.balanceCredit)
        : 0;

    double usedCredit = cl - bc;
    // double usedCreditAmt = double.parse(source)
    // usedCredit;

    MoneyFormatter usdcrdt = MoneyFormatter(amount: usedCredit);

    MoneyFormatterOutput usedcredt = usdcrdt.output;

    // String balcedCredit = bc.toStringAsFixed(2);

    MoneyFormatter balCred = MoneyFormatter(amount: bc);

    MoneyFormatterOutput balancedCrdt = balCred.output;

    String creditLimitAMt = cl.toStringAsFixed(2);

    print("usedCredit ======> $usedCredit");
    print("balcedCredit ======> $balancedCrdt");
    print("creditLimitAMt ======> $creditLimitAMt");
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            width: widget.maxWidth - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colours.wolfGrey, width: 1)),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h10p * .1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: w10p * .2,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(widget.image),
                      ),
                      SizedBox(
                        width: w10p * .5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              invoice?.seller?.companyName ?? "",
                              style: TextStyles.textStyle8,
                            ),
                            // AutoSizeText(
                            //   "Building name",
                            //   overflow: TextOverflow.ellipsis,
                            //   style: TextStyles.textStyle69,
                            // ),
                            AutoSizeText(
                              invoice?.seller?.address ?? "",
                              style: TextStyles.textStyle69,
                              maxLines: 2,
                            ),
                            AutoSizeText(
                              invoice?.seller?.state ?? "",
                              style: TextStyles.textStyle69,
                            ),
                            AutoSizeText(
                              invoice?.seller?.gstin ?? "",
                              style: TextStyles.textStyle69,
                            ),
                            // Row(
                            //   children: [
                            //     AutoSizeText(
                            //       "Credit Limit : ",
                            //       style: TextStyles.textStyle70,
                            //     ),
                            //     AutoSizeText(
                            //       "₹ $creditLimitAMt",
                            //       style: TextStyles.textStyle70,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h1p * 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colours.successIcon,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Used Credit",
                                style: TextStyles.textStyle71,
                              ),
                              Text(
                                "₹ ${usedcredt.nonSymbol}",
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Available Credit Limit",
                                // "Credit Limit",
                                style: TextStyles.textStyle71,
                              ),
                              Text(
                                "₹ ${balancedCrdt.nonSymbol}",
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}