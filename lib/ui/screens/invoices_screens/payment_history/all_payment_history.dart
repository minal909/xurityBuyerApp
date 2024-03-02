import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:xuriti/logic/view_models/trans_history_manager.dart';
import 'package:xuriti/models/core/payment_history_model.dart';
import 'package:xuriti/ui/screens/invoices_screens/payment_history/all_payment_details.dart';

import '../../../../models/helper/service_locator.dart';
import '../../../theme/constants.dart';

class AllPaymentHistory extends StatefulWidget {
  // String invoiceId;
  final double maxWidth;
  final double maxHeight;
  String companyName;
  String invoiceAmount;
  String invoiceDate;
  String dueDate;
  String paymentDate;
  TrancDetail fullDetails;
  String invoiceId;
  String sellerId;

  AllPaymentHistory(
      {
      // required this.invoiceId,
      required this.maxWidth,
      required this.invoiceId,
      required this.maxHeight,
      required this.companyName,
      required this.invoiceAmount,
      required this.invoiceDate,
      required this.dueDate,
      required this.paymentDate,
      required this.fullDetails,
      required this.sellerId});

  @override
  State<AllPaymentHistory> createState() => _AllPaymentHistoryState();
}

class _AllPaymentHistoryState extends State<AllPaymentHistory> {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  @override
  Widget build(BuildContext context) {
    final sellerName = [
      widget.fullDetails.sellerName.toString(),
    ];
    String getNewLineString() {
      StringBuffer sb = new StringBuffer();
      for (String line in sellerName) {
        sb.write(line + "\n");
      }
      return sb.toString();
    }

    String invAmount = double.parse(widget.invoiceAmount).toString();

    double invamt = double.parse(invAmount);
    MoneyFormatter amtinv = MoneyFormatter(amount: invamt);

    MoneyFormatterOutput invoiceamt = amtinv.output;

    DateTime idate = widget.invoiceDate.isEmpty
        ? DateTime.now()
        : DateTime.parse(widget.invoiceDate);

    String orderamt = double.parse(widget.fullDetails.orderAmount.toString())
        .toStringAsFixed(2);

    double oredramount = double.parse(orderamt);
    MoneyFormatter amtorder = MoneyFormatter(amount: oredramount);

    MoneyFormatterOutput OrderAmt = amtorder.output;

    DateTime ddate = widget.dueDate.isEmpty
        ? DateTime.now()
        : DateTime.parse(widget.dueDate);

    DateTime pdate = widget.paymentDate.isEmpty
        ? DateTime.now()
        : DateTime.parse(widget.paymentDate);

    String invoiceDate = DateFormat("dd-MMM-yyyy").format(idate);
    String dueDate = DateFormat("dd-MMM-yyyy").format(ddate);
    String paymentDate = DateFormat("dd-MMM-yyyy").format(pdate);

    DateTime currentDate = DateTime.now();
    Duration dif = ddate.difference(currentDate);
    TrancDetail transac = widget.fullDetails;

    int idLength = widget.invoiceId.length;

    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;
    double w1p = widget.maxWidth * 0.01;
    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
        child: Expandable(
          collapsed: ExpandableButton(
              child: Card(
                  child: Container(
                      height: 80,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colours.offWhite,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.fullDetails.invoiceNumber
                                              .toString(),
                                          style: TextStyles.textStyle6,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SvgPicture.asset(
                                            "assets/images/home_images/arrow-circle-right.svg"),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      height: 18.0,
                                      child: AutoSizeText(
                                        widget.fullDetails.sellerName
                                            .toString(),
                                        maxLines: 1,
                                        style: TextStyles.companyName,
                                      ),
                                    ),
                                  ]),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 5.0),
                                  child: Container(
                                    height: 12,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Center(
                                      child: Text(
                                        widget.fullDetails.paymentMode
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "₹ ${OrderAmt.nonSymbol}",
                                  style: TextStyles.textStyle58,
                                )
                              ],
                            )
                          ])))),
          expanded: Column(children: [
            ExpandableButton(
              child: Card(
                child: Container(
                    height: 130,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colours.offWhite,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Transaction Id : ",
                                        style: TextStyles.textStyle6,
                                      ),
                                      Text(
                                        widget.fullDetails.orderId.toString(),
                                        style: TextStyles.textStyle6,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Payment Date : ",
                                        style: TextStyles.textStyle6,
                                      ),
                                      Text(
                                        paymentDate,
                                        style: TextStyles.textStyle6,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Payment Mode : ",
                                        style: TextStyles.textStyle6,
                                      ),
                                      Text(
                                        widget.fullDetails.paymentMode
                                            .toString(),
                                        style: TextStyles.textStyle6,
                                      )
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       "Paid Amount : ",
                                  //       style: TextStyles.textStyle6,
                                  //     ),
                                  //     Text(
                                  //       "₹ ${invoiceamt.nonSymbol}",
                                  //       style: TextStyles.textStyle6,
                                  //     )
                                  //   ],
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Payment Status : ",
                                        style: TextStyles.textStyle6,
                                      ),
                                      Text(
                                        widget.fullDetails.orderStatus
                                            .toString(),
                                        style: TextStyles.textStyle6,
                                      )
                                    ],
                                  ),
                                ]),
                          ]),
                    )),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
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
            //           Text(
            //             invoiceDate,
            //             style: TextStyles.textStyle63,
            //           ),
            //           // Text(
            //           //   widget.companyName,
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
            //             dueDate,
            //             style: TextStyles.textStyle63,
            //           ),
            //           // Text(
            //           //   widget.companyName,
            //           //   style: TextStyles.textStyle64,
            //           // ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         SizedBox(
                  //           height: 4,
                  //         ),
                  //         Text(
                  //           "Invoice Amount",
                  //           style: TextStyles.textStyle62,
                  //         ),
                  //         Text(
                  //           "₹ $invAmount",
                  //           style: TextStyles.textStyle65,
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            "Paid Amount",
                            style: TextStyles.textStyle62,
                          ),
                          Text(
                            "₹ ${invoiceamt.nonSymbol}",
                            style: TextStyles.textStyle66,
                          )
                        ],
                      ),
                      SizedBox(
                        width: w10p * 2,
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     SizedBox(
                      //       height: 4,
                      //     ),
                      //     Text(
                      //       "Payment Date",
                      //       style: TextStyles.textStyle62,
                      //     ),
                      //     Text(
                      //       paymentDate,
                      //       style: TextStyles.textStyle66,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () async {
                          await getIt<TransHistoryManager>()
                              .changeSelectedPaymentHistory(transac);
                          // await   getIt<CompanyDetailsManager>()
                          //        .changeSelectedSellerId(widget.sellerId);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllPaymentDetails()));
                        },
                        child: Container(
                          width: 300,
                          height: 40,
                          child: Center(
                              child: Text(
                            "View Details",
                            style: TextStyles.textStyle195,
                          )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colours.pumpkin,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}






// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:money_formatter/money_formatter.dart';
// import 'package:provider/provider.dart';
// import 'package:xuriti/logic/view_models/trans_history_manager.dart';
// import 'package:xuriti/models/core/invoice_model.dart';
// import 'package:xuriti/models/core/payment_history_model.dart';
// import 'package:xuriti/ui/screens/invoices_screens/payment_history/all_payment_details.dart';

// import '../../../../logic/view_models/transaction_manager.dart';
// import '../../../../models/helper/service_locator.dart';
// import '../../../theme/constants.dart';

// class AllPaymentHistory extends StatefulWidget {
//   // String invoiceId;
//   final double maxWidth;
//   final double maxHeight;
//   String companyName;
//   String invoiceAmount;
//   String invoiceDate;
//   String dueDate;
//   String paymentDate;
//   TrancDetail fullDetails;
//   String invoiceId;
//   String sellerId;

//   AllPaymentHistory(
//       {
//       // required this.invoiceId,
//       required this.maxWidth,
//       required this.invoiceId,
//       required this.maxHeight,
//       required this.companyName,
//       required this.invoiceAmount,
//       required this.invoiceDate,
//       required this.dueDate,
//       required this.paymentDate,
//       required this.fullDetails,
//       required this.sellerId});

//   @override
//   State<AllPaymentHistory> createState() => _AllPaymentHistoryState();
// }

// class _AllPaymentHistoryState extends State<AllPaymentHistory> {
//   RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
//   String Function(Match) mathFunc = (Match match) => '${match[1]},';
//   @override
//   Widget build(BuildContext context) {
//     double? gstAmt;

//     Invoice? invoice = Provider.of<TransactionManager>(context).currentInvoice;
//     final sellerName = [
//       widget.fullDetails.sellerName.toString(),
//     ];
//     String getNewLineString() {
//       StringBuffer sb = new StringBuffer();
//       for (String line in sellerName) {
//         sb.write(line + "\n");
//       }
//       return sb.toString();
//     }

//     String invAmount = double.parse(widget.invoiceAmount).toString();
//     double invamt = double.parse(invAmount);
//     MoneyFormatter amtinv = MoneyFormatter(amount: invamt);
//     MoneyFormatterOutput invoiceamt = amtinv.output;
//     // MoneyFormatter amtinv = MoneyFormatter(amount: invAmount);
//     // MoneyFormatterOutput invoiceAmt = amtinv.output;

//     double outstandingAmt = double.parse(invoice?.outstandingAmount ?? "");
//     MoneyFormatter outamt = MoneyFormatter(amount: outstandingAmt);
//     MoneyFormatterOutput outstandAmt = outamt.output;

//     if (invoice?.billDetails?.gstSummary?.totalTax != "undefined") {
//       gstAmt =
//           double.tryParse(invoice?.billDetails?.gstSummary?.totalTax ?? "0")!;
//     } else {
//       gstAmt = 0;
//     }

//     double gstgst = gstAmt;
//     MoneyFormatter totalgst = MoneyFormatter(amount: gstgst);

//     MoneyFormatterOutput invgst = totalgst.output;

//     double totalInvoiceAmount = invamt + gstAmt;
//     MoneyFormatter totalamt = MoneyFormatter(amount: totalInvoiceAmount);

//     MoneyFormatterOutput invAmtTotal = totalamt.output;
//     // double totalAmtPaid = totalInvoiceAmount + interest - outstandingAmt;
//     // double totalAmtInAbs = totalAmtPaid;

//     double totalAmtPaid = totalInvoiceAmount - outstandingAmt;
//     double totalAmtInAbs = totalAmtPaid.abs();
//     MoneyFormatter absAmt = MoneyFormatter(amount: totalAmtInAbs);

//     MoneyFormatterOutput totalAbsAmt = absAmt.output;

//     return LayoutBuilder(builder: (context, constraints) {
//       // double invamt = double.parse(invAmount);
//       // MoneyFormatter amtinv = MoneyFormatter(amount: invamt);

//       // MoneyFormatterOutput invoiceamt = amtinv.output;

//       //DateTime idate = DateTime.parse(widget.invoiceDate);

//       DateTime idate = widget.invoiceDate.isEmpty
//           ? DateTime.now()
//           : DateTime.parse(widget.invoiceDate);

//       String orderamt = double.parse(widget.fullDetails.orderAmount.toString())
//           .toStringAsFixed(2);

//       double oredramount = double.parse(orderamt);
//       MoneyFormatter amtorder = MoneyFormatter(amount: oredramount);

//       MoneyFormatterOutput OrderAmt = amtorder.output;

//       // DateTime ddate = widget.dueDate.isEmpty
//       //     ? DateTime.now()
//       //     : DateTime.parse(widget.dueDate);

//       // DateTime pdate = DateTime.parse(widget.paymentDate);

//       // String invoiceDate = DateFormat("dd-MMM-yyyy").format(idate);
//       // String dueDate = DateFormat("dd-MMM-yyyy").format(ddate);
//       // String paymentDate = DateFormat("dd-MMM-yyyy").format(pdate);
//       DateTime ddate = widget.dueDate.isEmpty
//           ? DateTime.now()
//           : DateTime.parse(widget.dueDate);

//       DateTime pdate = widget.paymentDate.isEmpty
//           ? DateTime.now()
//           : DateTime.parse(widget.paymentDate);

//       String invoiceDate = DateFormat("dd-MMM-yyyy").format(idate);
//       String dueDate = DateFormat("dd-MMM-yyyy").format(ddate);
//       String paymentDate = DateFormat("dd-MMM-yyyy").format(pdate);

//       DateTime currentDate = DateTime.now();
//       Duration dif = ddate.difference(currentDate);
//       TrancDetail transac = widget.fullDetails;

//       int idLength = widget.invoiceId.length;

//       double h1p = widget.maxHeight * 0.01;
//       double h10p = widget.maxHeight * 0.1;
//       double w10p = widget.maxWidth * 0.1;
//       double w1p = widget.maxWidth * 0.01;
//       return ExpandableNotifier(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
//           child: Expandable(
//             collapsed: ExpandableButton(
//                 child: Card(
//                     child: Container(
//                         height: 80,
//                         padding: EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colours.offWhite,
//                         ),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             widget.fullDetails.invoiceNumber
//                                                 .toString(),
//                                             style: TextStyles.textStyle6,
//                                           ),
//                                           SizedBox(
//                                             width: 5,
//                                           ),
//                                           SvgPicture.asset(
//                                               "assets/images/home_images/arrow-circle-right.svg"),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         width: 100.0,
//                                         height: 18.0,
//                                         child: AutoSizeText(
//                                           widget.fullDetails.sellerName
//                                               .toString(),
//                                           maxLines: 1,
//                                           style: TextStyles.companyName,
//                                         ),
//                                       ),
//                                     ]),
//                               ),
//                               Column(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 15.0, vertical: 5.0),
//                                     child: Container(
//                                       height: 12,
//                                       width: 55,
//                                       decoration: BoxDecoration(
//                                           color: Colors.green,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10))),
//                                       child: Center(
//                                         child: Text(
//                                           widget.fullDetails.paymentMode
//                                               .toString(),
//                                           style: TextStyle(
//                                               fontSize: 10,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Text(
//                                     "₹ ${totalAbsAmt.nonSymbol}",
//                                     style: TextStyles.textStyle58,
//                                   )
//                                 ],
//                               )
//                             ])))),
//             expanded: Column(children: [
//               ExpandableButton(
//                 child: Card(
//                   child: Container(
//                       height: 130,
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colours.offWhite,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 8.0),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "Transaction Id : ",
//                                           style: TextStyles.textStyle6,
//                                         ),
//                                         Text(
//                                           widget.fullDetails.orderId.toString(),
//                                           style: TextStyles.textStyle6,
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "Payment Date : ",
//                                           style: TextStyles.textStyle6,
//                                         ),
//                                         Text(
//                                           paymentDate,
//                                           style: TextStyles.textStyle6,
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Payment Mode : ",
//                                           style: TextStyles.textStyle6,
//                                         ),
//                                         Text(
//                                           widget.fullDetails.paymentMode
//                                               .toString(),
//                                           style: TextStyles.textStyle6,
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Paid Amount : ",
//                                           style: TextStyles.textStyle6,
//                                         ),
//                                         Text(
//                                           //"₹ ${invoiceamt.nonSymbol}",
//                                           "₹ ${totalAbsAmt.nonSymbol}",
//                                           style: TextStyles.textStyle6,
//                                         )
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           "Payment Status : ",
//                                           style: TextStyles.textStyle6,
//                                         ),
//                                         Text(
//                                           widget.fullDetails.orderStatus
//                                               .toString(),
//                                           style: TextStyles.textStyle6,
//                                         )
//                                       ],
//                                     ),
//                                   ]),
//                             ]),
//                       )),
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(10),
//               //   child: Row(
//               //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //     children: [
//               //       Column(
//               //         crossAxisAlignment: CrossAxisAlignment.start,
//               //         children: [
//               //           SizedBox(
//               //             height: 4,
//               //           ),
//               //           Text(
//               //             "Invoice Date",
//               //             style: TextStyles.textStyle62,
//               //           ),
//               //           Text(
//               //             invoiceDate,
//               //             style: TextStyles.textStyle63,
//               //           ),
//               //           // Text(
//               //           //   widget.companyName,
//               //           //   style: TextStyles.textStyle64,
//               //           // ),
//               //         ],
//               //       ),
//               //       SvgPicture.asset("assets/images/arrow.svg"),
//               //       Column(
//               //         crossAxisAlignment: CrossAxisAlignment.end,
//               //         children: [
//               //           SizedBox(
//               //             height: 4,
//               //           ),
//               //           Text(
//               //             "Due Date",
//               //             style: TextStyles.textStyle62,
//               //           ),
//               //           Text(
//               //             dueDate,
//               //             style: TextStyles.textStyle63,
//               //           ),
//               //           // Text(
//               //           //   widget.companyName,
//               //           //   style: TextStyles.textStyle64,
//               //           // ),
//               //         ],
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   children: [
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //   children: [
//                     //     Column(
//                     //       crossAxisAlignment: CrossAxisAlignment.start,
//                     //       children: [
//                     //         SizedBox(
//                     //           height: 4,
//                     //         ),
//                     //         Text(
//                     //           "Invoice Amount",
//                     //           style: TextStyles.textStyle62,
//                     //         ),
//                     //         Text(
//                     //           "₹ $invAmount",
//                     //           style: TextStyles.textStyle65,
//                     //         )
//                     //       ],
//                     //     ),
//                     //   ],
//                     // ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(
//                               height: 4,
//                             ),
//                             const Text(
//                               "Payment Amount",
//                               style: TextStyles.textStyle62,
//                             ),
//                             Text(
//                               "₹ ${totalAbsAmt.nonSymbol}",
//                               style: TextStyles.textStyle66,
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           width: w10p * 2,
//                         ),
//                         // Column(
//                         //   crossAxisAlignment: CrossAxisAlignment.end,
//                         //   children: [
//                         //     SizedBox(
//                         //       height: 4,
//                         //     ),
//                         //     Text(
//                         //       "Payment Date",
//                         //       style: TextStyles.textStyle62,
//                         //     ),
//                         //     Text(
//                         //       paymentDate,
//                         //       style: TextStyles.textStyle66,
//                         //     ),
//                         //   ],
//                         // ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: InkWell(
//                           onTap: () async {
//                             await getIt<TransHistoryManager>()
//                                 .changeSelectedPaymentHistory(transac);
//                             // await   getIt<CompanyDetailsManager>()
//                             //        .changeSelectedSellerId(widget.sellerId);

//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => AllPaymentDetails()));
//                           },
//                           child: Container(
//                             width: 300,
//                             height: 40,
//                             child: Center(
//                                 child: Text(
//                               "View Details",
//                               style: TextStyles.textStyle195,
//                             )),
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(5)),
//                               color: Colours.pumpkin,
//                             ),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       );
//     });
//   }
// }