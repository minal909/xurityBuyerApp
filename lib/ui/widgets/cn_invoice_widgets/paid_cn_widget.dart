import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../models/helper/service_locator.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class PaidCNInvoiceWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final bool isOverdue;
  final String amount;
  final String savedAmount;
  final String invoiceDate;
  final String dueDate;
  final String gst;
  final String invoiceAmount;
  Invoice fullDetails;

  final String companyName;
  PaidCNInvoiceWidget(
      {required this.invoiceAmount,
      required this.gst,
      required this.fullDetails,
      required this.maxWidth,
      required this.maxHeight,
      required this.amount,
      required this.savedAmount,
      required this.invoiceDate,
      required this.dueDate,
      required this.companyName,
      required this.isOverdue});

  @override
  Widget build(BuildContext context) {
    double gstAmt;
    String? invoiceId = fullDetails.sId;
    String paidInvAmount = double.parse(amount).toStringAsFixed(2);
    double inv = double.parse(amount);
    if (gst != "undefined" && gst.runtimeType == num) {
      gstAmt = double.parse(gst);
    } else {
      gstAmt = 0;
    }
    double invAmt = double.parse(invoiceAmount);
    double payableAMt = invAmt + gstAmt - inv;
    double gstAmount = invAmt - inv;

    DateTime id = DateTime.parse(invoiceDate);
    DateTime dd = DateTime.parse(dueDate);
    DateTime currentDate = DateTime.now();
    Duration dif = dd.difference(currentDate);
    int daysLeft = dif.inDays;
    String idueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(id);

    String invDueDate = "${fullDetails.invoiceDueDate}";
    DateTime idd = DateTime.parse(invDueDate);
    String invoicedueDate = DateFormat("dd-MMM-yyyy").format(idd);

    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
        child: Expandable(
            collapsed: ExpandableButton(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colours.offWhite,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isOverdue
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: h1p * 1),
                                    child: Container(
                                      // height: h1p * 4.5,
                                      // width: w10p * 1.7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colours.failPrimary,
                                      ),
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Text(
                                            "Overdue",
                                            style: TextStyles.overdue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),

                            Row(
                              children: [
                                Text(
                                  "${fullDetails.invoiceNumber} ",
                                  style: TextStyles.textStyle6,
                                ),
                                SvgPicture.asset(
                                    "assets/images/home_images/arrow-circle-right.svg"),
                              ],
                            ),

                            Text(
                              companyName,
                              style: TextStyles.companyName,
                            ),
                            // isOverdue?
                            //  Text(
                            //   "interest charged",
                            //   style: TextStyles.textStyle102,
                            // ):,
                            // const Text(
                            //   "You Save",
                            //   style: TextStyles.textStyle102,
                            // ),
                            // Text(
                            //   "₹ $savedAmount",
                            //   style: isOverdue?
                            //   TextStyles.textStyle61 :
                            //   TextStyles.textStyle100,
                            // )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            isOverdue
                                ? Text(
                                    "$daysLeft days Overdue",
                                    style: TextStyles.textStyle57,
                                  )
                                : Text(
                                    "Paid Amount",
                                    style: TextStyles.textStyle57,
                                  ),
                            Text(
                              "₹ ${payableAMt.toStringAsFixed(2)}",
                              style: TextStyles.textStyle58,
                            ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
            expanded: Column(
              children: [
                ExpandableButton(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colours.offWhite,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isOverdue
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: h1p * 1),
                                        child: Container(
                                          // height: h1p * 4.4,
                                          // width: w10p * 1.7,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colours.failPrimary,
                                          ),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(3.5),
                                              child: Text(
                                                "Overdue",
                                                style: TextStyles.overdue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Row(
                                  children: [
                                    Text(
                                      "${fullDetails.invoiceNumber} ",
                                      style: TextStyles.textStyle6,
                                    ),
                                    SvgPicture.asset(
                                        "assets/images/home_images/rightArrow.svg"),
                                  ],
                                ),

                                Text(
                                  companyName,
                                  style: TextStyles.companyName,
                                ),
                                // isOverdue? const Text(
                                //   "Interest charged",
                                //   style: TextStyles.textStyle102,
                                // ):
                                // Text(
                                //   "You Save",
                                //   style: TextStyles.textStyle102,
                                // ),
                                // Text(
                                //   "₹ $savedAmount",
                                //   style:isOverdue?
                                //   TextStyles.textStyle61:
                                //   TextStyles.textStyle100,
                                // )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                isOverdue
                                    ? Text(
                                        "$daysLeft days Overdue",
                                        style: TextStyles.textStyle57,
                                      )
                                    : Text(
                                        "Paid Amount",
                                        style: TextStyles.textStyle57,
                                      ),
                                Text(
                                  "₹ ${payableAMt.toStringAsFixed(2)}",
                                  style: TextStyles.textStyle58,
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
                Card(
                  elevation: .5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                            //   companyName,
                            //   style: TextStyles.companyName,
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
                              invoicedueDate,
                              style: TextStyles.textStyle63,
                            ),
                            // Text(
                            //   "Updated At",
                            //   style: TextStyles.textStyle62,
                            // ),
                            // Text(
                            //   idueDate,
                            //   style: TextStyles.textStyle63,
                            // ),
                            // Text(
                            //   companyName,
                            //   style: TextStyles.companyName,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Row(
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
                                  "₹ ${payableAMt.toStringAsFixed(2)}",
                                  style: TextStyles.textStyle65,
                                )
                                //    Text("Asian Paints",style: TextStyles.textStyle34,),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                isOverdue
                                    ? Text(
                                        "Payabe Amount",
                                        style: TextStyles.textStyle62,
                                      )
                                    : Text(
                                        "Paid Amount",
                                        style: TextStyles.textStyle62,
                                      ),
                                Text(
                                  "₹ ${payableAMt.toStringAsFixed(2)}",
                                  style: TextStyles.textStyle66,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h1p * 1.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isOverdue
                                    ? const Text(
                                        "Interest",
                                        style: TextStyles.textStyle62,
                                      )
                                    : Container()
                                // const Text(
                                //   "You Save",
                                //   style: TextStyles.textStyle62,
                                // ),
                                // Text(
                                //   "₹ $savedAmount",
                                //   style:isOverdue?
                                //   TextStyles.textStyle73:
                                //   TextStyles.textStyle77,
                                // ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: GestureDetector(
                              onTap: () {
                                isOverdue
                                    ? Navigator.pushNamed(
                                        context, overdueDetails)
                                    : getIt<TransactionManager>()
                                        .changePaidInvoice(fullDetails);

                                Navigator.pushNamed(
                                    context, paidInvoiceDetails);
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colours.pumpkin,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
