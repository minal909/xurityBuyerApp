import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/models/core/payment_history_model.dart';

import '../../../../logic/view_models/trans_history_manager.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/leading.dart';
import '../../../widgets/profile/profile_widget.dart';

class AllPaymentDetails extends StatefulWidget {
  String? image;
  String? companyName;
  String? companyAddress;
  String? state;
  String? gstNo;
  String? creditLimit;
  String? balanceCredit;
  TrancDetail? fullDetails;
  AllPaymentDetails({
    this.image,
    this.companyName,
    this.companyAddress,
    this.state,
    this.gstNo,
    this.creditLimit,
    this.balanceCredit,
    this.fullDetails,
  });

  @override
  State<AllPaymentDetails> createState() => _AllPaymentDetailsState();
}

class _AllPaymentDetailsState extends State<AllPaymentDetails> {
  GlobalKey<ScaffoldState> ssk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TrancDetail? transDetail = getIt<TransHistoryManager>().transDetail;
    Invoice? invoice =
        Provider.of<TransactionManager>(context).currentPaidInvoice;

    String companyName = transDetail!.sellerName ?? '';
    String invoiceId = transDetail.invoiceNumber ?? '';
    String orderId = transDetail.orderId ?? '';
    String paymentMode = transDetail.paymentMode ?? '';
    String invoiceD = transDetail.createdAt ?? "";
    String paymentD = transDetail.createdAt ?? "";
    String dueD = transDetail.createdAt ?? "";
    // DateTime idate = DateTime.parse(invoiceD);
    DateTime idate =
        invoiceD.isEmpty ? DateTime.now() : DateTime.parse(invoiceD);

    DateTime ddate = dueD.isEmpty ? DateTime.now() : DateTime.parse(dueD);

    // DateTime pdate = DateTime.parse(paymentD);
    DateTime pdate =
        paymentD.isEmpty ? DateTime.now() : DateTime.parse(paymentD);

    String invoiceDate = DateFormat("dd-MMM-yyyy").format(idate);
    String dueDate = DateFormat("dd-MMM-yyyy").format(ddate);
    String paymentDate = DateFormat("dd-MMM-yyyy").format(pdate);
    String invAmount =
        double.parse(transDetail.orderAmount ?? "").toStringAsFixed(2);
    double invamt = double.parse(invAmount);
    MoneyFormatter amtinv = MoneyFormatter(amount: invamt);

    MoneyFormatterOutput invoiceamt = amtinv.output;

    String orderStatus = transDetail.orderStatus ?? "";

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return SafeArea(
        child: Scaffold(
            key: ssk,
            backgroundColor: Colours.black,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: h10p * 2.2,
              flexibleSpace: ProfileWidget(pskey: ssk),
            ),
            body: Container(
                width: maxWidth,
                height: maxHeight,
                decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 13, top: 8, right: 13),
                  child: ListView(children: [
                    LeadingWidget(
                      heading: "Back",
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            width: maxWidth - 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colours.wolfGrey, width: 1)),
                            child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: h10p * .1,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: w10p * .2,
                                        ),
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundImage: AssetImage(
                                              "assets/images/company-vector.png"),
                                        ),
                                        SizedBox(
                                          width: w10p * .5,
                                        ),
                                        Expanded(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                              AutoSizeText(
                                                companyName,
                                                style: TextStyles.textStyle8,
                                              ),
                                              AutoSizeText(
                                                  invoice?.seller?.address ??
                                                      "",
                                                  style:
                                                      TextStyles.textStyle63),
                                              AutoSizeText(
                                                  invoice?.seller?.state ?? "",
                                                  style:
                                                      TextStyles.textStyle63),
                                              AutoSizeText(
                                                  invoice?.seller!.gstin ?? "",
                                                  style:
                                                      TextStyles.textStyle43),
                                            ]))
                                      ])
                                ]))),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w10p * .6, vertical: h1p * 1),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colours.successIcon,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: h1p * 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Invoice ID",
                                      style: TextStyles.textStyle62,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "$invoiceId",
                                      style: TextStyles.textStyle56,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "Payment Status",
                                      style: TextStyles.textStyle62,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "$orderStatus",
                                      style: TextStyles.textStyle56,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: w10p * .6, vertical: h1p * 1),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             height: 4,
                    //           ),
                    //           Text(
                    //             "Invoice Date",
                    //             style: TextStyles.textStyle62,
                    //           ),
                    //           invoiceDate == null
                    //               ? Text("")
                    //               : Text(
                    //                   invoiceDate,
                    //                   style: TextStyles.textStyle66,
                    //                 ),
                    //           // Text(
                    //           //   companyName == null ? "" : companyName,
                    //           //   style: TextStyles.textStyle64,
                    //           // ),
                    //         ],
                    //       ),
                    //       SvgPicture.asset("assets/images/arrow.svg"),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: [
                    //           SizedBox(
                    //             height: 4,
                    //           ),
                    //           Text(
                    //             "Due Date",
                    //             style: TextStyles.textStyle62,
                    //           ),
                    //           Text(
                    //             dueDate == null ? "" : dueDate,
                    //             style: TextStyles.textStyle66,
                    //           ),
                    //           // Text(
                    //           //   companyName == null ? "" : companyName,
                    //           //   style: TextStyles.textStyle64,
                    //           // ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: w10p * .6, vertical: h1p * 1),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             height: 4,
                    //           ),
                    //           Text(
                    //             "Invoice Amount",
                    //             style: TextStyles.textStyle62,
                    //           ),
                    //           Text(
                    //             "₹ $invAmount",
                    //             style: TextStyles.textStyle65,
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const Text(
                              //       "Paid Amount",
                              //       style: TextStyles.textStyle62,
                              //     ),
                              //     Text(
                              //       "₹ ${invoiceamt.nonSymbol}",
                              //       style: TextStyles.textStyle140,
                              //     ),
                              //   ],
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Payment Date",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(paymentDate),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Transaction Id",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    orderId,
                                    style: TextStyles.textStyle140,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Payment Mode",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    paymentMode,
                                    style: TextStyles.textStyle140,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // BillDetailsWidget(
                    //     maxHeight: maxHeight,
                    //     maxWidth: maxWidth,
                    //     heading: "transDetail"),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15),
                    //   child: Row(
                    //     children: const [
                    //       Text(
                    //         "Added rewards",
                    //         style: TextStyles.textStyle38,
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Card(
                    //   elevation: 1,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(15),
                    //     child: Container(
                    //       height: h10p * 2,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         color: Colours.offWhite,
                    //       ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //         children: [
                    //           Padding(
                    //             padding: EdgeInsets.symmetric(vertical: h1p * 2),
                    //             child: Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Container(
                    //                     height: h1p * 3,
                    //                     width: w10p * 2.4,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(4),
                    //                       color: Colours.peach,
                    //                     ),
                    //                     child: Center(
                    //                       child: Text(
                    //                         "Xuriti Rewards",
                    //                         style: TextStyles.textStyle45,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   SizedBox(
                    //                     height: 5,
                    //                   ),
                    //                   const Text(
                    //                     "Free Credit Period Extention",
                    //                     style: TextStyles.textStyle44,
                    //                   ),
                    //                   const Text(
                    //                     "of 7 Days for upto ₹ 75,000/-",
                    //                     style: TextStyles.textStyle44,
                    //                   ),
                    //                   Image.asset("assets/images/claimButton.png")
                    //                 ]),
                    //           ),
                    //           SizedBox(
                    //             height: h1p * .6,
                    //           ),
                    //           Image.asset("assets/images/claimlogo.png")
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: h10p * .5,
                    )
                  ]),
                ))),
      );
    });
  }
}
