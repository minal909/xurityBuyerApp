import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/models/core/transactional_model.dart';
import 'package:xuriti/ui/screens/reports_screens/transaction_ledger/transactional_ledger.dart';

import '../../../theme/constants.dart';

class LedgerInv extends StatefulWidget {
  List<dynamic> ledgerTransactions;
  String invoiceID;
  String account;
  String createdAt;
  String transactionType;

  String accountType;
  String? invoiceId;
  String balance;

  String? recordType;
  String? counterParty;

  dynamic? transactionAmount;
  // Invoice currentInvoice;
  LedgerInv({
    required this.ledgerTransactions,
    required this.accountType,
    required this.balance,
    required this.invoiceID,
    required this.recordType,
    required this.counterParty,
    required this.account,
    required this.createdAt,
    required this.transactionAmount,
    required this.transactionType,
    // required this.currentInvoice,
  });

  @override
  State<LedgerInv> createState() => _LedgerInvState();
}

class _LedgerInvState extends State<LedgerInv> {
  Transaction? transac;
  Invoice? invoices;

  @override
  Widget build(BuildContext context) {
    // DateTime dd = new DateFormat("dd-MM-yyyy").parse(widget.dueDate);
    // var inputDate = DateTime.parse(dd.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    // String outputDate = outputFormat.format(inputDate);

    // DateTime.parse(widget.dueDate); //invoice due date
    DateTime date = DateTime.parse(widget.createdAt);
    // List txnLedger = widget.ledgerTransactions[0];
    String trancDate = DateFormat("dd-MMM-yyyy").format(date);
    DateTime ledgerDate = DateTime.parse(widget.createdAt); //invoice date
    var inputDate = DateTime.parse(ledgerDate.toString());
    var oFormat = DateFormat('MM/dd/yyyy hh:mm a');
    String outputDate = oFormat.format(inputDate);

    DateTime currentDate = DateTime.now();
    String invId = widget.invoiceID;

    // String dueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(ledgerDate);
    // widget.ledgerTransactions
    //     .sort((invId, ledgerDate) => invId.compareTo(ledgerDate));
    // String _updatingDate(BuildContext context) {
    //   if (currentDate.isBefore(dueDate as DateTime)) {
    //     Text(dif.toString());
    //   } else {
    //     Text(dif1.toString());
    //   }
    //   return _updatingDate(context);
    // }

    // String invId = widget.invoiceNumber.substring(widget.invoiceNumber.length-4,widget.invoiceNumber.length);
    // "# ${fullDetails.sId!.substring(fullDetails.sId!.length-4,fullDetails.sId!.length)} ",
    // String createdAt =
    //     (double.tryParse(widget.createdAt) ?? 0).toStringAsFixed(2);

    String transacAmount =
        double.parse(widget.transactionAmount).toStringAsFixed(2);
    // dynamic outstandingcreatedAt = (widget.fullDetails.outstandingcreatedAt);
    // dynamic osamt = double.parse(outstandingcreatedAt);

    // dynamic interest = (widget.fullDetails.interest);

    // dynamic discount = (widget.fullDetails.discount);

    // dynamic payablecreatedAt = osamt + interest - discount;

    // print("******************PayablecreatedAt***********$payablecreatedAt");

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return ExpandableNotifier(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TransactionalLedger(
                          txn: [widget.ledgerTransactions],
                          account: widget.account,
                          accountType: widget.accountType,
                          balance: widget.balance,
                          counterParty: widget.counterParty,
                          createdAt: widget.createdAt,
                          invoiceID: widget.invoiceID,
                          recordType: widget.recordType.toString(),
                          transactionType: widget.transactionType,
                          transactionAmount: widget.transactionAmount,
                        )),
              );
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colours.offWhite
                    //     ?
                    //     :
                    ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AutoSizeText(
                                widget.invoiceID,
                                style: TextStyles.textStyle6,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              // SvgPicture.asset(
                              //     "assets/images/home_images/arrow-circle-right.svg"),
                            ],
                          ),
                          SizedBox(
                            width: 100.0,
                            height: 30.0,
                            child: AutoSizeText(
                              widget.account,
                              maxLines: 1,
                              style: TextStyles.companyName,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 115,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Transaction Date",
                            style: TextStyles.textStyle62,
                          ),
                          Text(
                            trancDate,
                            style: TextStyles.textStyle63,
                          ),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     widget.fullDetails.invoiceType == "IN"
                      //         ? widget.fullDetails.discount != 0
                      //             ? Column(
                      //                 children: [
                      //                   // Padding(
                      //                   //     padding: EdgeInsets.fromLTRB(
                      //                   //         70, 20, 0, 0)),
                      //                   Text(
                      //                     "Discount",
                      //                     style: TextStyles.textStyle62,
                      //                   ),
                      //                   Text(
                      //                     "₹ ${widget.fullDetails.discount?.toStringAsFixed(2)}",
                      //                     style: TextStyles.textStyle143,
                      //                   ),
                      //                 ],
                      //               )
                      //             : Column(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.start,
                      //                 children: [
                      //                   Text(
                      //                     "Interest",
                      //                     style: TextStyles.textStyle62,
                      //                   ),
                      //                   Text(
                      //                     "₹ ${widget.fullDetails.interest?.toStringAsFixed(2)}",
                      //                     style: TextStyles.textStyle142,
                      //                   ),
                      //                 ],
                      //               )
                      //         : Container(),
                      //   ],
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // widget.fullDetails.invoiceType == "IN"
                          //     ? Text(
                          //         currentDate.isAfter(dd)
                          //             ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                          //             : " Due since ${currentDate.difference(id).inDays.toString()} days",
                          //         style: TextStyles.textStyle57,
                          //       )
                          //     : Container(),
                          // Text(
                          //   "₹ $createdAt",
                          //   style: TextStyles.textStyle58,
                          // ),
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ),
        // expanded: Column(
        //   children: [
        //     ExpandableButton(
        //       child: Card(
        //         child: Container(
        //           padding: EdgeInsets.all(10),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: invoices?.invoiceType == "IN"
        //                 ? Colours.offWhite
        //                 : Color(0xfffcdcb4),
        //           ),
        //           child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Row(
        //                       children: [
        //                         Text(
        //                           widget.transactionType,
        //                           style: TextStyles.textStyle6,
        //                         ),
        //                         SizedBox(
        //                           width: 6,
        //                         ),
        //                         SvgPicture.asset(
        //                             "assets/images/home_images/rightArrow.svg"),
        //                         SizedBox(
        //                           width: 190,
        //                         ),
        //                         Text(
        //                           "₹ $transacAmount",
        //                           style: TextStyles.textStyle58,
        //                         ),
        //                       ],
        //                     ),
        //                     Text(
        //                       widget.invoiceID,
        //                       style: TextStyles.companyName,
        //                     ),
        //                   ],
        //                 ),
        //                 Column(
        //                   children: [
        //                     // widget.fullDetails.invoiceType == "IN"
        //                     //     ? widget.fullDetails.discount != 0
        //                     //         ? Column(
        //                     //             // mainAxisAlignment:
        //                     //             //     MainAxisAlignment.center,
        //                     //             children: [
        //                     //               Padding(
        //                     //                   padding:
        //                     //                       EdgeInsets.all(10)),
        //                     //               Text(
        //                     //                 "Discount",
        //                     //                 style: TextStyles.textStyle62,
        //                     //               ),
        //                     //               Text(
        //                     //                 "₹ ${widget.fullDetails.discount?.toStringAsFixed(2)}",
        //                     //                 style:
        //                     //                     TextStyles.textStyle143,
        //                     //               ),
        //                     //             ],
        //                     //           )
        //                     //         : Column(
        //                     //             mainAxisAlignment:
        //                     //                 MainAxisAlignment.center,
        //                     //             children: [
        //                     //               Text(
        //                     //                 "Interest",
        //                     //                 style: TextStyles.textStyle62,
        //                     //               ),
        //                     //               Text(
        //                     //                 "₹ ${widget.fullDetails.interest?.toStringAsFixed(2)}",
        //                     //                 style:
        //                     //                     TextStyles.textStyle142,
        //                     //               ),
        //                     //             ],
        //                     //           )
        //                     //     : Container(),
        //                   ],
        //                 ),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.end,
        //                   children: [
        //                     // widget.fullDetails.invoiceType == "IN"
        //                     //     ? Text(
        //                     //         //  " Payments Pending since 10 days",
        //                     //         currentDate.isAfter(dd)
        //                     //             ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
        //                     //             : " Due since ${currentDate.difference(id).inDays.toString()} days",
        //                     //         style: TextStyles.textStyle57,
        //                     //       )
        //                     //     : Container(),
        //                     // Text(
        //                     //   "₹ $amount",
        //                     //   style: TextStyles.textStyle58,
        //                     // ),
        //                   ],
        //                 )
        //               ]),
        //         ),
        //       ),
        //     ),
        //     Card(
        //       elevation: .5,
        //       child: Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 SizedBox(
        //                   height: 4,
        //                 ),
        //                 Text(
        //                   "Transaction Date",
        //                   style: TextStyles.textStyle62,
        //                 ),
        //                 Text(
        //                   invDate.toString(),
        //                   style: TextStyles.textStyle63,
        //                 ),
        //                 // Text(
        //                 //   widget.companyName,
        //                 //   style: TextStyles.companyName,
        //                 // ),
        //               ],
        //             ),
        //             // Column(
        //             //   crossAxisAlignment: CrossAxisAlignment.start,
        //             //   children: [
        //             //     SizedBox(
        //             //       height: 4,
        //             //     ),
        //             //     Text(
        //             //       "Outstanding Amount",
        //             //       style: TextStyles.textStyle62,
        //             //     ),
        //             //     Text(
        //             //       "₹ $amount",
        //             //       style: TextStyles.textStyle65,
        //             //     )
        //             //     //    Text("Asian Paints",style: TextStyles.textStyle34,),
        //             //   ],
        //             // ),
        //             // SvgPicture.asset("assets/images/arrow.svg"),
        //             // Column(
        //             //   crossAxisAlignment: CrossAxisAlignment.end,
        //             //   children: [
        //             //     SizedBox(
        //             //       height: 4,
        //             //     ),
        //             //     Text(
        //             //       "Due Date",
        //             //       style: TextStyles.textStyle62,
        //             //     ),
        //             //     Text(
        //             //       outputDate.toString(),
        //             //       style: TextStyles.textStyle63,
        //             //     ),
        //             //     // Text(
        //             //     //   widget.companyName,
        //             //     //   style: TextStyles.companyName,
        //             //     // ),
        //             //   ],
        //             // ),
        //           ],
        //         ),
        //       ),
        //     ),
        //     Card(
        //       child: Container(
        //         padding: EdgeInsets.all(10),
        //         decoration: BoxDecoration(),
        //         child: Column(
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 // Column(
        //                 //   crossAxisAlignment: CrossAxisAlignment.end,
        //                 //   children: [
        //                 //     SizedBox(
        //                 //       height: 4,
        //                 //     ),
        //                 //     Text(
        //                 //       "Payable Amount",
        //                 //       style: TextStyles.textStyle62,
        //                 //     ),
        //                 //     Text(
        //                 //       "₹ $payableAmount",
        //                 //       style: TextStyles.textStyle66,
        //                 //     ),
        //                 //   ],
        //                 // ),
        //               ],
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.symmetric(vertical: 10.0),
        //               child: GestureDetector(
        //                   onTap: () async {
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                           builder: (context) =>
        //                               TransactionalLedger(
        //                                 txn: [widget.ledgerTransactions],
        //                                 account: widget.account,
        //                                 accountType: widget.accountType,
        //                                 balance: widget.balance,
        //                                 counterParty: widget.counterParty,
        //                                 createdAt: widget.createdAt,
        //                                 invoiceID: widget.invoiceID,
        //                                 recordType: widget.recordType,
        //                                 transactionType:
        //                                     widget.transactionType,
        //                                 transactionAmount:
        //                                     widget.transactionAmount,
        //                               )),
        //                     );
        //                   },
        //                   child: Image.asset(
        //                       "assets/images/viewetails.png")),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // )),
      );
    });
  }
}
