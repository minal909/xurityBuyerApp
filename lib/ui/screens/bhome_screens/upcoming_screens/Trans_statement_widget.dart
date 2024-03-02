import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';

import '../../../theme/constants.dart';
import '../../invoices_screens/Inv_transaction.dart';

class transStatementWidget extends StatefulWidget {
  List invtrns;
  String seller;
  String invcDate;
  String transType;
  String transAmount;
  String transDate;
  String amountCleared;
  String interest;
  String discount;
  String remarks;
  // TransactionInvoice invoice;

  // Invoice currentInvoice;
  transStatementWidget({
    required this.invtrns,
    required this.seller,
    required this.invcDate,
    required this.transType,
    required this.transAmount,
    required this.transDate,
    required this.amountCleared,
    required this.interest,
    required this.discount,
    required this.remarks,
    // required this.invoice,

    // required this.currentInvoice,
  });

  @override
  State<transStatementWidget> createState() => _transStatementWidgetState();
}

class _transStatementWidgetState extends State<transStatementWidget> {
  @override
  Widget build(BuildContext context) {
    // DateTime dd = new DateFormat("dd-MM-yyyy").parse(widget.dueDate);
    // var inputDate = DateTime.parse(dd.toString());
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    // String outputDate = outputFormat.format(inputDate);

    // DateTime.parse(widget.dueDate); //invoice due date
    DateTime id2 = DateTime.parse(widget.invcDate); //invoice date
    String invcDate = DateFormat("dd-MMM-yyyy").format(id2);

    DateTime id = DateTime.parse(widget.transDate); //invoice date
    var inputDate = DateTime.parse(id.toString());
    var oFormat = DateFormat('MM/dd/yyyy hh:mm a');
    String outputDate = oFormat.format(inputDate);

    DateTime currentDate = DateTime.now();

    // String dueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(id);

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
    String amount = double.parse(widget.transAmount).toStringAsFixed(2);

    // dynamic outstandingAmount = (widget.fullDetails.outstandingAmount);
    // dynamic osamt = double.parse(outstandingAmount);

    // dynamic interest = (widget.fullDetails.interest);

    // dynamic discount = (widget.fullDetails.discount);

    // dynamic payableAmount = osamt + interest - discount;

    // print("******************PayableAmount***********$payableAmount");

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
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
                      color: Color(0xfffcdcb4),
                      //     ?
                      //     :
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  AutoSizeText(
                                    widget.transType,
                                    style: TextStyles.textStyle6,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/home_images/arrow-circle-right.svg"),
                                ],
                              ),
                              Text(
                                widget.transType,
                                style: TextStyles.companyName,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹ ",
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
                          // color: widget.fullDetails.invoiceType == "IN"
                          //     ? Colours.offWhite
                          //     : Color(0xfffcdcb4),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.transType,
                                        style: TextStyles.textStyle6,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      SvgPicture.asset(
                                          "assets/images/home_images/rightArrow.svg"),
                                    ],
                                  ),
                                  Text(
                                    widget.transType,
                                    style: TextStyles.companyName,
                                  ),
                                ],
                              ),
                              Column(
                                children: [],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "₹ $amount",
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
                                invDate.toString(),
                                style: TextStyles.textStyle63,
                              ),
                              // Text(
                              //   widget.companyName,
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
                            children: [],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  InvTransactions(
                                    invtr: [widget.invtrns],
                                    invcDate: '${widget.invcDate}',
                                    invoiceNo: '${widget.interest}',
                                    seller: '${widget.seller}',
                                  );
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
    });
  }
}
