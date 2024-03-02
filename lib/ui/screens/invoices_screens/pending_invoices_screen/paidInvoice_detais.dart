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

class PaidInvoiceDetails extends StatefulWidget {
  const PaidInvoiceDetails({Key? key}) : super(key: key);

  @override
  State<PaidInvoiceDetails> createState() => _PaidInvoiceDetailsState();
}

class _PaidInvoiceDetailsState extends State<PaidInvoiceDetails> {
  String GstAmt = '';

  @override
  Widget build(BuildContext context) {
    Invoice? invoice =
        Provider.of<TransactionManager>(context).currentPaidInvoice;
    DateTime id = DateTime.parse(invoice!.invoiceDate ?? '');
    DateTime dd = DateTime.parse(invoice.updatedAt ?? '');
    DateTime duedate = DateTime.parse(invoice.invoiceDueDate ?? '');

    DateTime currentDate = DateTime.now();
    Duration dif = dd.difference(currentDate);
    int daysLeft = dif.inDays;

    String idueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(id);
    String invDue = DateFormat("dd-MMM-yyyy").format(duedate);

    double gstAmt;
    String paidInvAmount =
        double.parse(invoice.outstandingAmount ?? "").toStringAsFixed(2);
    double paidinv = double.parse(paidInvAmount);
    MoneyFormatter paidinvamt = MoneyFormatter(amount: paidinv);

    MoneyFormatterOutput invpaidamt = paidinvamt.output;

    double inv = double.parse(invoice.outstandingAmount ?? "");
    num discount = double.parse(invoice.discount.toString());
    String strdisc = discount.toString();
    double dbldisc = double.parse(strdisc);
    MoneyFormatter mndisc = MoneyFormatter(amount: dbldisc);

    MoneyFormatterOutput thediscount = mndisc.output;

    // num interest = double.parse(invoice.paidInterest.toString());
    num interest = double.parse(invoice.paidInterest.toString());
    String strint = interest.toString();
    double dblintr = double.parse(strint);
    MoneyFormatter mnintr = MoneyFormatter(amount: dblintr);

    MoneyFormatterOutput theinterest = mnintr.output;

    String gst = invoice.billDetails!.gstSummary?.totalTax ?? "";
    gstAmt = double.parse(gst);

    MoneyFormatter gAmt = MoneyFormatter(amount: gstAmt);

    MoneyFormatterOutput gstAmount = gAmt.output;

    if (invoice.billDetails?.gstSummary?.totalTax != null &&
        invoice.billDetails?.gstSummary?.totalTax == num) {
      gstAmt = double.tryParse((invoice.billDetails?.gstSummary?.totalTax)!)!;

      setState(() {
        MoneyFormatter gAmt = MoneyFormatter(amount: gstAmt);

        MoneyFormatterOutput gstAmount = gAmt.output;
        String GstAmt = gstAmount.nonSymbol;
        this.GstAmt = GstAmt;
      });
    }
    double invAmt = double.tryParse((invoice.invoiceAmount)!)!;

    MoneyFormatter Amtamt = MoneyFormatter(amount: invAmt);

    MoneyFormatterOutput AmtInv = Amtamt.output;
    double payableAMt = invAmt + gstAmt - inv + interest - discount;

    MoneyFormatter payAmt = MoneyFormatter(amount: payableAMt);

    MoneyFormatterOutput amtPayable = payAmt.output;

    // double paidAmt = invAmt?? 0 - inv;

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
            SizedBox(
              height: h10p * .3,
            ),
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
                                    "Invoice Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${AmtInv.nonSymbol}",
                                    style: TextStyles.textStyle140,
                                  ),
                                  // Text(
                                  //   "Paid Amount",
                                  //   style: TextStyles.textStyle62,
                                  // ),
                                  // Text(
                                  //   "₹ ${amtPayable.nonSymbol}",
                                  //   style: TextStyles.textStyle56,
                                  // ),
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
                                    "Invoice Due Date",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    invDue,
                                    style: TextStyles.textStyle140,
                                  ),
                                  // Text(
                                  //   "Uploaded At",
                                  //   style: TextStyles.textStyle62,
                                  // ),
                                  // Text(
                                  //   idueDate,
                                  //   style: TextStyles.textStyle63,
                                  // ),
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
                    //                 "Invoice Amount",
                    //                 style: TextStyles.textStyle62,
                    //               ),
                    //               Text(
                    //                 "₹ ${AmtInv.nonSymbol}",
                    //                 style: TextStyles.textStyle140,
                    //               ),
                    //               // Text(
                    //               //   invoice.seller!.companyName ?? '',
                    //               //   style: TextStyles.textStyle64,
                    //               // ),
                    //             ],
                    //           ),
                    //           // Column(
                    //           //   crossAxisAlignment: CrossAxisAlignment.end,
                    //           //   children: [
                    //           //     SizedBox(
                    //           //       height: 4,
                    //           //     ),
                    //           //     Text(
                    //           //       "GST Amount",
                    //           //       style: TextStyles.textStyle62,
                    //           //     ),
                    //           //     Text(
                    //           //       gstAmt.toString(),
                    //           //       style: TextStyles.textStyle63,
                    //           //     ),
                    //           //     // Text(
                    //           //     //   invoice.seller!.companyName ?? '',
                    //           //     //   style: TextStyles.textStyle64,
                    //           //     // ),
                    //           //   ],
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
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
                                    "GST Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${gstAmount.nonSymbol}",
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
                                    "₹ ${invpaidamt.nonSymbol}",
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
                                    "₹ ${thediscount.nonSymbol}",
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
                                    "₹ ${theinterest.nonSymbol}",
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
                                    idueDate,
                                    style: TextStyles.textStyle63,
                                  ),
                                  // Text(
                                  //   "Invoice Due Date",
                                  //   style: TextStyles.textStyle62,
                                  // ),
                                  // Text(
                                  //   invDue,
                                  //   style: TextStyles.textStyle140,
                                  // ),
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

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        width: 200,
                        // width: maxWidth,
                        height: 40,
                        color: Colors.white,
                        child: GestureDetector(
                            onTap: () async {
                              // progress!.show();
                              if (invoice.invoiceFile!.isNotEmpty) {
                                await getIt<TransactionManager>()
                                    .openFile(url: invoice.invoiceFile ?? "");
                                // progress.dismiss();
                                Fluttertoast.showToast(
                                    webPosition: "center",
                                    msg: "Opening invoice file");
                              } else {
                                Fluttertoast.showToast(
                                    webPosition: "center",
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
