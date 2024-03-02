import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/core/invoice_model.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/company_details.dart';
import '../../../widgets/profile/profile_widget.dart';

class SavemoreDetails extends StatefulWidget {
  const SavemoreDetails({Key? key}) : super(key: key);

  @override
  State<SavemoreDetails> createState() => _SavemoreDetailsState();
}

class _SavemoreDetailsState extends State<SavemoreDetails> {
  String gstamount = '';

  @override
  Widget build(BuildContext context) {
    Invoice? invoice = Provider.of<TransactionManager>(context).currentInvoice;

    DateTime id = DateTime.parse(invoice!.invoiceDate ?? '');
    DateTime dd = DateTime.parse(invoice.invoiceDueDate ?? '');

    DateTime currentDate = DateTime.now();
    Duration dif = dd.difference(currentDate);
    num discount = double.parse(invoice.paidDiscount.toString());
    String discstr = discount.toString();
    double dbldisc = double.parse(discstr);
    MoneyFormatter amtdisc = MoneyFormatter(amount: dbldisc);

    MoneyFormatterOutput discnt = amtdisc.output;

    num interest = double.parse(invoice.paidInterest.toString());

    String intrst = interest.toString();
    double dblintrst = double.parse(intrst);
    MoneyFormatter moneyintrst = MoneyFormatter(amount: dblintrst);

    MoneyFormatterOutput interestamt = moneyintrst.output;

    String gst = invoice.billDetails!.gstSummary!.totalTax ?? "";
    double invAmt = double.parse(invoice.invoiceAmount ?? "");
    MoneyFormatter amtinv = MoneyFormatter(amount: invAmt);

    MoneyFormatterOutput InvAmt = amtinv.output;

    double inv = double.parse(invoice.outstandingAmount ?? "");
    double paidAmt = invAmt - inv;
    int daysLeft = dif.inDays;
    double gstAmt;

    if (gst != "undefined") {
      // Text(
      //   // " Payments Pending since 10 days",
      //   currentDate.isAfter(dd)
      //       ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
      //       : " Due since ${currentDate.difference(id).inDays.toString()} days",
      //   //" ${daysLeft.toString()} days left",
      //   style: TextStyles.textStyle57,
      //   textAlign: TextAlign.center,
      // ),
      gstAmt = double.parse(gst);

      MoneyFormatter amtgst = MoneyFormatter(amount: gstAmt);

      MoneyFormatterOutput GSTAmt = amtgst.output;
      String gstamount = GSTAmt.nonSymbol;
      this.gstamount = gstamount;
    } else {
      gstAmt = 0;
    }

    double outamt = double.parse(invoice.outstandingAmount.toString());
    MoneyFormatter outStAmt = MoneyFormatter(amount: outamt);

    MoneyFormatterOutput invOutStnd = outStAmt.output;

    String idueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(id);

    DateTime update = DateTime.parse(invoice.updatedAt ?? '');
    String updatedDate = DateFormat("dd-MMM-yyyy").format(update);

    String paidInvAmount =
        double.parse(invoice.outstandingAmount ?? "").toStringAsFixed(2);
    double paidamt = double.parse(paidInvAmount);
    MoneyFormatter amtpd = MoneyFormatter(amount: paidamt);

    MoneyFormatterOutput pdAmt = amtpd.output;

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colours.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * 2.2,
            flexibleSpace: ProfileWidget(),
          ),
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
              child: Padding(
                padding: const EdgeInsets.only(left: 13, top: 8, right: 13),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 13),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context, landing);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/arrowLeft.svg"),
                            SizedBox(
                              width: w10p * .3,
                            ),
                            const Text(
                              "Back",
                              style: TextStyles.textStyle41,
                            ),
                          ],
                        ),
                      ),
                    ),
                    CompanyDetailsWidget(
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
                    // Text(
                    //   // " Payments Pending since 10 days",
                    //   currentDate.isAfter(dd)
                    //       ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                    //       : " Due since ${currentDate.difference(id).inDays.toString()} days",
                    //   //" ${daysLeft.toString()} days left",
                    //   style: TextStyles.textStyle57,
                    //   textAlign: TextAlign.center,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        height: h1p * 10,
                        width: w10p * 3,
                        decoration: BoxDecoration(
                          color: Colours.pearlGrey,
                          borderRadius: BorderRadius.circular(17),
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
                                    "Invoice ID",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "${invoice.invoiceNumber!}",
                                    style: TextStyles.textStyle56,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Payable Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${pdAmt.nonSymbol}",
                                    style: TextStyles.textStyle56,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //  Text(
                    //   "$daysLeft days left",
                    //   style: TextStyles.textStyle57,
                    //   textAlign: TextAlign.center,
                    // ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Invoice Date",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    invDate,
                                    style: TextStyles.textStyle63,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                              SvgPicture.asset("assets/images/arrow.svg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Due Date",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    idueDate,
                                    style: TextStyles.textStyle63,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Invoice Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${InvAmt.nonSymbol}",
                                    style: TextStyles.textStyle140,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "GST Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ $gstamount",
                                    style: TextStyles.textStyle140,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Outstanding Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${invOutStnd.nonSymbol}",
                                    style: TextStyles.textStyle140,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Discount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${discnt.nonSymbol}",
                                    style: TextStyles.textStyle143,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Interest",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${interestamt.nonSymbol}",
                                    style: TextStyles.textStyle142,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: .5,
                      child: Container(
                        height: h1p * 10,
                        color: Colours.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Uploaded At",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    updatedDate,
                                    style: TextStyles.textStyle63,
                                  ),
                                  // Text(
                                  //   invoice.seller!.companyName ?? '',
                                  //   style: TextStyles.textStyle64,
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Card(
                    //   elevation: .5,
                    //   child: Container(
                    //     height: h1p * 10,
                    //     color: Colours.white,
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: w10p * .50),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               SizedBox(
                    //                 height: 4,
                    //               ),
                    //               Text(
                    //                 "Invoice Date",
                    //                 style: TextStyles.textStyle62,
                    //               ),
                    //               Text(
                    //                 invDate.toString(),
                    //                 style: TextStyles.textStyle140,
                    //               ),
                    //               // Text(
                    //               //   invoice.seller!.companyName ?? '',
                    //               //   style: TextStyles.textStyle64,
                    //               // ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    //             SizedBox(
                    //   height: h1p * 2,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        width: 200,
                        // width: maxWidth,
                        height: 40,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: GestureDetector(
                              onTap: () async {
                                // progress!.show();
                                if (invoice.invoiceFile!.isNotEmpty) {
                                  await getIt<TransactionManager>()
                                      .openFile(url: invoice.invoiceFile ?? "");
                                  // progress.dismiss();
                                  Fluttertoast.showToast(
                                      msg: "Opening invoice file");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Invoice file not found");
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: invoice.invoiceFile!.isNotEmpty
                                        ? Colours.tangerine
                                        : Colors.grey),
                                child: Center(
                                  child: Text("Download Invoices",
                                      style: TextStyles.textStyle150),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ]),
        ),
      );
    });
  }
}
// Card(
//   elevation: .5,
//   child: Padding(
//     padding:  EdgeInsets.symmetric(horizontal: w10p * .5,vertical: h1p * 1),
//     child: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:  [
//                 SizedBox(
//                   height: 4,
//                 ),
//         //         Text(
//         //           "Invoice Amt",
//         //           style: TextStyles.textStyle62,
//         //         ),
//         //         Text(
//         //           "₹ ${invoice.invoiceAmount.toString()}",
//         //           style: TextStyles.textStyle65,
//         //         )
//         //       ],
//         //     ),
//         //     SizedBox(
//         //       width: w10p * 4.5,
//         //     ),
//         //     Column(
//         //       crossAxisAlignment: CrossAxisAlignment.end,
//         //       children:  [
//         //         SizedBox(
//         //           height: 4,
//         //         ),
//         //         Text(
//         //           "Pay Now",
//         //           style: TextStyles.textStyle62,
//         //         ),
//         //         Text(
//         //           "₹ ${invoice.invoiceAmount.toString()}",
//         //           style: TextStyles.textStyle66,
//         //         ),
//         //       ],
//         //     ),
//         //   ],
//         // ),
//         // SizedBox(
//         //   height: h1p * 1,
//         // ),
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   mainAxisAlignment: MainAxisAlignment.start,
//         //   children: const [
//         //     Text(
//         //       "You Save",
//         //       style: TextStyles.textStyle62,
//         //     ),
//         //   ],
//         // ),
//         // Row(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   mainAxisAlignment: MainAxisAlignment.start,
//         //   children: const [
//         //     Text(
//         //       "₹ 545",
//         //       style: TextStyles.textStyle77,
//         //     ),
//         //   ],
//         // ),
//         // Padding(
//         //   padding:
//         //        EdgeInsets.symmetric(horizontal: w10p * .2,vertical: h1p * 1),
//         //   child: Container(
//         //     height: h10p * .6,
//         //     decoration: BoxDecoration(
//         //       borderRadius: BorderRadius.circular(6),
//         //       color: Colours.successPrimary,
//         //     ),
//         //     child: const Center(
//         //       child: Text(
//         //         "Pay Now",
//         //         style: TextStyles.textStyle46,
//         //       ),
//         //     ),
//         //   ),
//         // )
//       ],
//     ),
//   ),
// ),
