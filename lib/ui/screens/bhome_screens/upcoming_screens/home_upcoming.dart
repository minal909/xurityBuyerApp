import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/invoice_model.dart';

import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';

class HomeUpcoming extends StatefulWidget {
  final companyName;
  // String getNewLineString() {
  //   StringBuffer sb = new StringBuffer();
  //   for (String line in companyName) {
  //     sb.write(line + "\n");
  //   }
  //   return sb.toString();
  // }

  Invoice fullDetails;

  String amount;
  String invoiceDate;
  String dueDate;
  String invoiceNumber;
  String payableAmount;

  HomeUpcoming({
    required this.invoiceNumber,
    required this.fullDetails,
    required this.companyName,
    required this.amount,
    required this.invoiceDate,
    required this.dueDate,
    required this.payableAmount,
  });

  @override
  State<HomeUpcoming> createState() => _HomeUpcomingState();
}

class _HomeUpcomingState extends State<HomeUpcoming> {
  @override
  Widget build(BuildContext context) {
    final company12 = [widget.companyName];
    String getNewLineString() {
      StringBuffer sb = new StringBuffer();
      for (String line in company12) {
        sb.write(line + "\n");
      }
      return sb.toString();
    }

    DateTime dd = DateTime.parse(widget.dueDate); //invoice due date
    DateTime id = DateTime.parse(widget.invoiceDate); //invoice date
    DateTime currentDate = DateTime.now();
    String dueDate = DateFormat("dd-MMM-yyyy").format(dd);
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
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    double Outamount = double.parse(widget.amount);

    MoneyFormatter amtOut = MoneyFormatter(amount: Outamount);

    MoneyFormatterOutput outAmount = amtOut.output;

    dynamic outstandingAmount = (widget.fullDetails.outstandingAmount);
    dynamic osamt = double.parse(outstandingAmount);

    dynamic interest = (widget.fullDetails.interest);
    String intr = interest.toString();

    double intst = double.parse(intr);

    MoneyFormatter intamt = MoneyFormatter(amount: intst);

    MoneyFormatterOutput theInterest = intamt.output;

    dynamic discount = (widget.fullDetails.discount);

    dynamic payableAmount = (osamt + interest - discount).toString();
    double pamount = double.parse(payableAmount);

    MoneyFormatter payAmt = MoneyFormatter(amount: pamount);

    MoneyFormatterOutput payableAMT = payAmt.output;

    print("******************PayableAmount***********$payableAmount");
    bool checkid = false;
    getIt<SharedPreferences>().setBool('checkId', checkid);
   

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
                      color: widget.fullDetails.invoiceType == "IN"
                          ? Colours.offWhite
                          : Color(0xfffcdcb4),
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
                                    widget.invoiceNumber,
                                    style: TextStyles.textStyle6,
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/home_images/arrow-circle-right.svg"),
                                ],
                              ),
                              SizedBox(),
                              Container(
                                width: 120,
                                child: Text(
                                  getNewLineString(),
                                  // widget.companyName,
                                  // overflow: TextOverflow.ellipsis,
                                  //maxLines: 1,
                                  //   // maxLines: 3,
                                  style: TextStyles.companyName,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.fullDetails.invoiceType == "IN"
                                    ? widget.fullDetails.discount != 0
                                        ? Column(
                                            children: [
                                              // Padding(
                                              //     padding: EdgeInsets.fromLTRB(
                                              //         70, 20, 0, 0)),
                                              Text(
                                                "Discount",
                                                style: TextStyles.textStyle62,
                                              ),
                                              Text(
                                                "₹ ${widget.fullDetails.discount?.toStringAsFixed(2)}",
                                                style: TextStyles.textStyle143,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Interest",
                                                style: TextStyles.textStyle62,
                                              ),
                                              Text(
                                                "₹ ${theInterest.nonSymbol}",
                                                style: TextStyles.textStyle142,
                                              ),
                                            ],
                                          )
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.fullDetails.invoiceType == "IN"
                                    ? widget.fullDetails.discount != 0
                                        ? Column(
                                            children: [
                                              // Padding(
                                              //     padding: EdgeInsets.fromLTRB(
                                              //         70, 20, 0, 0)),
                                              Text(
                                                "Discount",
                                                style: TextStyles.textStyle62,
                                              ),
                                              Text(
                                                "₹ ${widget.fullDetails.discount?.toStringAsFixed(2)}",
                                                style: TextStyles.textStyle143,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Interest",
                                                style: TextStyles.textStyle62,
                                              ),
                                              Text(
                                                "₹ ${theInterest.nonSymbol}",
                                                style: TextStyles.textStyle142,
                                              ),
                                            ],
                                          )
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              widget.fullDetails.invoiceType == "IN"
                                  ? Text(
                                      currentDate.isAfter(dd)
                                          ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                                          : " Due since ${currentDate.difference(id).inDays.toString()} days",
                                      style: TextStyles.textStyle57,
                                    )
                                  : Container(),
                              Text(
                                "₹ ${outAmount.nonSymbol}",
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
                          color: widget.fullDetails.invoiceType == "IN"
                              ? Colours.offWhite
                              : Color(0xfffcdcb4),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.invoiceNumber,
                                        style: TextStyles.textStyle6,
                                      ),
                                      SvgPicture.asset(
                                          "assets/images/home_images/rightArrow.svg"),
                                    ],
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      getNewLineString(),
                                      // maxLines: 2,
                                      style: TextStyles.companyName,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  widget.fullDetails.invoiceType == "IN"
                                      ? widget.fullDetails.discount != 0
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              
                                              children: [
                                                // Padding(
                                                //     padding:
                                                //         EdgeInsets.all(10)),
                                                Text(
                                                  "Discount",
                                                  style: TextStyles.textStyle62,
                                                ),
                                                Text(
                                                  "₹ ${widget.fullDetails.discount?.toStringAsFixed(2)}",
                                                  style:
                                                      TextStyles.textStyle143,
                                                ),
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Interest",
                                                  style: TextStyles.textStyle62,
                                                ),
                                                Text(
                                                  "₹ ${theInterest.nonSymbol}",
                                                  style:
                                                      TextStyles.textStyle142,
                                                ),
                                              ],
                                            )
                                      : Container(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.fullDetails.invoiceType == "IN"
                                      ? Text(
                                          //  " Payments Pending since 10 days",
                                          currentDate.isAfter(dd)
                                              ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                                              : " Due since ${currentDate.difference(id).inDays.toString()} days",
                                          style: TextStyles.textStyle57,
                                        )
                                      : Container(),
                                  Text(
                                    "₹ ${outAmount.nonSymbol}",
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
                                dueDate.toString(),
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
                                    "₹ ${outAmount.nonSymbol}",
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
                                  Text(
                                    "Payable Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${payableAMT.nonSymbol}",
                                    style: TextStyles.textStyle66,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  getIt<TransactionManager>()
                                      .changeSelectedInvoice(
                                          widget.fullDetails);
                                  Navigator.pushNamed(context, upcomingDetails);
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
