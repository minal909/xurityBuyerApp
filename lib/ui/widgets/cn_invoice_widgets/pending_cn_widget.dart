import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/all_pending_invoices.dart';
import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/pending_invoice_report.dart';
import 'package:xuriti/ui/widgets/kyc_widgets/submitt_button.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../models/helper/service_locator.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

//change for refress cnInvoices screen
class PendingCNInvoiceWidget extends StatefulWidget {
  final double maxWidth;
  final Function? refreshingMethod;
  final double maxHeight;
  final bool isOverdue;
  final String amount;
  final String savedAmount;
  final String invoiceDate;
  final String dueDate;
  Invoice fullDetails;
  int index;
  bool userConsentGiven = false;
  List<Invoice> pendingInvoice = [];
  final String companyName;
  String? companystatus;
  final Function rebuildHomeScreen;

  PendingCNInvoiceWidget({
    required this.fullDetails,
    required this.maxWidth,
    required this.maxHeight,
    required this.amount,
    required this.savedAmount,
    required this.index,
    required this.invoiceDate,
    required this.dueDate,
    required this.companyName,
    required this.isOverdue,
    this.refreshingMethod,
    required this.rebuildHomeScreen,
  });

  @override
  _PendingCNInvoiceWidgetStatefulState createState() =>
      _PendingCNInvoiceWidgetStatefulState();
}

//
class _PendingCNInvoiceWidgetStatefulState
    extends State<PendingCNInvoiceWidget> {
  // final double maxWidth;
  // final Function? refreshingMethod;
  // final double maxHeight;
  // final bool isOverdue;
  // final String amount;
  // final String savedAmount;
  // final String invoiceDate;
  // final String dueDate;
  // Invoice fullDetails;
  // int index;
  // bool userConsentGiven = false;
  // List<Invoice> pendingInvoice = [];
  // final String companyName;
  // String? companystatus;
  // final Function rebuildHomeScreen;
  // PendingCNInvoiceWidget(
  //     {required this.fullDetails,
  //     required this.maxWidth,
  //     required this.maxHeight,
  //     required this.amount,
  //     required this.savedAmount,
  //     required this.index,
  //     required this.invoiceDate,
  //     required this.dueDate,
  //     required this.companyName,
  //     required this.isOverdue,
  //     this.refreshingMethod,
  //     required this.rebuildHomeScreen});

  // // get widget => null;

//
  late double maxWidth;
  late double maxHeight;
  late bool isOverdue;
  late String amount;
  late String savedAmount;
  late String invoiceDate;
  late String dueDate;
  late Invoice fullDetails;
  late int index;
  late bool userConsentGiven;
  late List<Invoice> pendingInvoice;
  late String companyName;
  String? companystatus;

  @override
  void initState() {
    super.initState();
    // Initialize the fields using the widget properties
    maxWidth = widget.maxWidth;
    maxHeight = widget.maxHeight;
    isOverdue = widget.isOverdue;
    amount = widget.amount;
    savedAmount = widget.savedAmount;
    invoiceDate = widget.invoiceDate;
    dueDate = widget.dueDate;
    fullDetails = widget.fullDetails;
    index = widget.index;
    userConsentGiven = widget.userConsentGiven;
    pendingInvoice = widget.pendingInvoice;
    companyName = widget.companyName;
    companystatus = widget.companystatus;
  }

//
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

   

    TextEditingController acceptController = TextEditingController();
    TextEditingController rejectController = TextEditingController();
    ExpandableController _controller = ExpandableController();

    String? invoiceId = fullDetails.sId;
    companystatus = fullDetails.invoiceStatus;
    double invAmt = double.parse(amount);
    MoneyFormatter fmf = MoneyFormatter(amount: invAmt);

    MoneyFormatterOutput invamount = fmf.output;

    DateTime id = DateTime.parse(invoiceDate);
    DateTime dd = DateTime.parse(dueDate);
    DateTime currentDate = DateTime.now();
    Duration dif = dd.difference(currentDate);
    int daysLeft = dif.inDays;
    String idueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(id);

    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return ProgressHUD(child: Builder(builder: (context) {
      final progress = ProgressHUD.of(context);
      return ExpandableNotifier(
        controller: _controller,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 15),
          child: Expandable(
              collapsed: ExpandableButton(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colours.offWhite
                        // color: fullDetails.invoiceType == "IN"
                        //     ? Colours.offWhite
                        //     : Color(0xfffcdcb4),
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
                                        // height: h1p * 4.5,
                                        // width: w10p * 1.7,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                  SizedBox(
                                    width: 100,
                                    // height: 30,
                                    child: Text(
                                      "${fullDetails.invoiceNumber}",
                                      style: TextStyles.textStyle6,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/home_images/arrow-circle-right.svg"),
                                ],
                              ),

                              SizedBox(
                                width: 100.0,
                                height: 30.0,
                                child: AutoSizeText(
                                  companyName,
                                  maxLines: 1,
                                  style: TextStyles.companyName,
                                ),
                              ),

                              // Text(
                              //   companyName,
                              //   style: TextStyles.companyName,
                              // ),
                              // isOverdue?
                              // const Text(
                              //   "interest charged",
                              //   style: TextStyles.textStyle102,
                              // ):
                              // // const Text(
                              // //  "You Save",
                              // //   style: TextStyles.textStyle102,
                              // // ),
                              // Text(
                              //   "₹ $savedAmount",
                              //  style: isOverdue?
                              //  TextStyles.textStyle61 :
                              //   TextStyles.textStyle100,
                              // )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.0),
                            
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Status",
                                    style: TextStyles.textStyle57,
                                  ),
                                  Text(
                                    "$companystatus",
                                    style: TextStyles.textStyle57,
                                  ),
                                ],
                              ),
                          
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Text(
                              //   currentDate.isAfter(dd)
                              //       ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                              //       : " Due since ${currentDate.difference(id).inDays.toString()} days",
                              //   style: TextStyles.textStyle57,
                              // ),
                              SizedBox(
                                width: 110,
                                height: 45,
                                child: Text(
                                  "₹ ${invamount.nonSymbol}",
                                  style: TextStyles.textStyle58,
                                ),
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
                                        "${fullDetails.invoiceNumber}",
                                        style: TextStyles.textStyle6,
                                      ),
                                      SvgPicture.asset(
                                          "assets/images/home_images/rightArrow.svg"),
                                    ],
                                  ),

                                  SizedBox(
                                    width: 100.0,
                                    height: 30.0,
                                    child: AutoSizeText(
                                      companyName,
                                      maxLines: 1,
                                      style: TextStyles.companyName,
                                    ),
                                  ),

                                  // Text(
                                  //   companyName,
                                  //   style: TextStyles.companyName,
                                  // ),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Status",
                                    style: TextStyles.textStyle57,
                                  ),
                                  Text(
                                    "$companystatus",
                                    style: TextStyles.textStyle57,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Text(
                                  //   currentDate.isAfter(dd)
                                  //       ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                                  //       : " Due since ${currentDate.difference(id).inDays.toString()} days",
                                  //   style: TextStyles.textStyle57,
                                  // ),

                                  Text(
                                    "₹ ${invamount.nonSymbol}",
                                    style: TextStyles.textStyle63,
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
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
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
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "Due Date",
                                style: TextStyles.textStyle62,
                              ),
                              Text(
                                idueDate,
                                style: TextStyles.textStyle63,
                              ),
                              // Text(
                              //  companyName,
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
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(),
                      child: Column(
                        children: [
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
                                    "Outstanding Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${invamount.nonSymbol}",
                                    style: TextStyles.textStyle65,
                                  )
                                  //    Text("Asian Paints",style: TextStyles.textStyle34,),
                                ],
                              ),
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.end,
                              //   children: [
                              //     const SizedBox(
                              //       height: 4,
                              //     ),
                              //     isOverdue
                              //         ? const Text(
                              //             "Payabe Amount",
                              //             style: TextStyles.textStyle62,
                              //           )
                              //         : const Text(
                              //             "Pay Now",
                              //             style: TextStyles.textStyle62,
                              //           ),
                              //     Text(
                              //       "₹ ${invamount.nonSymbol}",
                              //       style: TextStyles.textStyle66,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: h1p * 1.5,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         isOverdue?
                          //         const Text(
                          //           "Interest",
                          //           style: TextStyles.textStyle62,
                          //         ):
                          //         const Text(
                          //           "You Save",
                          //           style: TextStyles.textStyle62,
                          //         ),
                          //         Text(
                          //           "₹ $savedAmount",
                          //           style:isOverdue?
                          //           TextStyles.textStyle73:
                          //           TextStyles.textStyle77,
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  context.showLoader();
                                  context.showLoader();
                                  ////progress!.show();
                                  getIt<TransactionManager>()
                                      .changeSelectedInvoice(fullDetails);
                                  // // progress.dismiss();
                                  context.hideLoader();
                                  context.hideLoader();
                                  Navigator.pushNamed(context, savemoreDetails);
                                  //Navigator.pushNamed(context, cnInvoices);
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
                          Row(
                            children: [
                              if (fullDetails.invoiceStatus == "Pending")
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        // vertical: h10p * 5,
                                                        ),
                                                child: AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0))),
                                                  title: Row(
                                                    children: const [
                                                      Center(
                                                        child: Text("Comment"),
                                                      ),
                                                    ],
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            rejectController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    "Leave a comment *"),
                                                        onChanged: (_) {
                                                          acceptController
                                                                  .text.isEmpty
                                                              ? Row(
                                                                  children: const [
                                                                    Text(
                                                                      "Please write a reason",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container();
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: h1p * 5,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          if (rejectController
                                                              .text
                                                              .isNotEmpty) {
                                                            userConsentGiven =
                                                                false;
                                                            String timeStamp =
                                                                DateTime.now()
                                                                    .toString();
                                                            context
                                                                .showLoader();
                                                            // progress!.show();
                                                            context
                                                                .showLoader();
                                                            // progress!.show();
                                                            print(
                                                                acceptController
                                                                    .text);
                                                            String message = await getIt<
                                                                    TransactionManager>()
                                                                .changeInvoiceStatus(
                                                                    invoiceId,
                                                                    "Rejected",
                                                                    index,
                                                                    fullDetails,
                                                                    timeStamp,
                                                                    userConsentGiven,
                                                                    rejectController
                                                                        .text,
                                                                    "NA");
                                                            // progress.dismiss();
                                                            context
                                                                .hideLoader();
                                                            // progress.dismiss();
                                                            context
                                                                .hideLoader();
                                                            //change for refress cnInvoices screen
                                                            // if (widget
                                                            //         .refreshingMethod !=
                                                            //     null) {
                                                            //   widget
                                                            //       .refreshingMethod!();
                                                            // }
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        behavior:
                                                                            SnackBarBehavior
                                                                                .floating,
                                                                        content:
                                                                            Text(
                                                                          message,
                                                                          style:
                                                                              const TextStyle(color: Colors.red),
                                                                        )));
//change for refress cnInvoices screen
                                                            setState(() {
                                                              // widget.fullDetails
                                                              //         .invoiceStatus =
                                                              //     rejectController
                                                              //         .text;
                                                              // widget
                                                              //     .pendingInvoice
                                                              //     .removeWhere((item) =>
                                                              //         item.sId ==
                                                              //         widget
                                                              //             .fullDetails
                                                              //             .sId);
                                                              // widget
                                                              //     .pendingInvoice
                                                              //     .add(widget
                                                              //         .fullDetails);
                                                              // widget
                                                              //     .rebuildHomeScreen();
                                                              // Navigator.pop(
                                                              //     context);

                                                              widget.fullDetails
                                                                      .invoiceStatus =
                                                                  rejectController
                                                                      .text;
                                                              widget
                                                                  .pendingInvoice
                                                                  .removeWhere((item) =>
                                                                      item.sId ==
                                                                      widget
                                                                          .fullDetails
                                                                          .sId);
                                                              widget
                                                                  .pendingInvoice
                                                                  .add(widget
                                                                      .fullDetails);
                                                              _controller
                                                                      .expanded =
                                                                  false;
                                                              _controller
                                                                      .expanded =
                                                                  false;
                                                              widget
                                                                  .rebuildHomeScreen();
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Please write a reason",
                                                                textColor:
                                                                    Colors.red);
                                                          }
                                                        },
                                                        child: Container(
                                                          height: h1p * 8,
                                                          width: w10p * 7.5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              color: Colours
                                                                  .pumpkin),
                                                          child: const Center(
                                                              child: Text(
                                                            "Save",
                                                            style: TextStyles
                                                                .subHeading,
                                                          )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )).then((value) async {
                                        String? id = getIt<SharedPreferences>()
                                            .getString('companyId');
                                        Provider.of<TransactionManager>(context,
                                                listen: false)
                                            .getInetialInvoices(
                                                id: id,
                                                resetConfirmedInvoices: true);
                                        // if (refreshingMethod != null) {
                                        //   refreshingMethod!();
                                        // }
                                      });
                                    },
                                    child: Container(
                                      height: h1p * 9,
                                      decoration: BoxDecoration(
                                          color: Colours.failPrimary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Text(
                                          "Reject",
                                          style: TextStyles.textStyle46,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (fullDetails.invoiceStatus == "Pending")
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      if (fullDetails.invoiceStatus ==
                                          "Pending")
                                        showDialog(
                                            context: context,
                                            builder: (context) => Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      // vertical: h10p * 4,
                                                      ),
                                                  child: AlertDialog(
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0))),
                                                    title: const Center(
                                                      child: Text("Consent"),
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        fullDetails.invoiceType ==
                                                                "CN"
                                                            ? Text(
                                                                "I agree and approve that credit note- ${fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to $companyName")
                                                            : Text(
                                                                "I agree and approve that credit note ${fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to $companyName."),
                                                        TextField(
                                                          controller:
                                                              acceptController,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Leave a comment *"),
                                                          onChanged: (_) {
                                                            print(
                                                                acceptController
                                                                    .text);
                                                            acceptController
                                                                    .text
                                                                    .isEmpty
                                                                ? Row(
                                                                    children: const [
                                                                      Text(
                                                                        "Please write a reason",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Container();
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: h1p * 4,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            userConsentGiven =
                                                                true;
                                                            String timeStamp =
                                                                DateTime.now()
                                                                    .toString();
                                                            if (acceptController
                                                                .text
                                                                .isNotEmpty) {
                                                              //  progress!.show();
                                                              context
                                                                  .showLoader();
                                                              //  progress!.show();
                                                              context
                                                                  .showLoader();

                                                              String? message =
                                                                  await getIt<
                                                                          TransactionManager>()
                                                                      .changeInvoiceStatus(
                                                                invoiceId,
                                                                "Confirmed",
                                                                index,
                                                                fullDetails,
                                                                timeStamp,
                                                                userConsentGiven,
                                                                acceptController
                                                                    .text,
                                                                fullDetails.invoiceType ==
                                                                        "CN"
                                                                    ? "I agree and  approve Xuriti and it's financing partner ${fullDetails.nbfcName} is authorised to disburse funds to the Seller $companyName for invoice -${fullDetails.invoiceNumber} on my behalf."
                                                                    : "I agree and approve that credit note ${fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to $companyName.",
                                                              );
                                                              // progress
                                                              //     .dismiss();
                                                              context
                                                                  .hideLoader();
                                                              // progress
                                                              //     .dismiss();
                                                              context
                                                                  .hideLoader();
                                                              //change for refress cnInvoices screen
                                                              // if (widget
                                                              //         .refreshingMethod !=
                                                              //     null) {
                                                              //   widget
                                                              //       .refreshingMethod!();
                                                              // }

                                                              print(
                                                                  '${message} ====================>');
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(
                                                                      SnackBar(
                                                                          behavior: SnackBarBehavior
                                                                              .floating,
                                                                          content:
                                                                              Text(
                                                                            message!,
                                                                            style:
                                                                                const TextStyle(color: Colors.green),
                                                                          )));
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Please write a reason",
                                                                  textColor:
                                                                      Colors
                                                                          .red);
                                                            }
                                                            //change for refress cnInvoices screen
                                                            setState(() {
                                                              widget.fullDetails
                                                                      .invoiceStatus =
                                                                  acceptController
                                                                      .text;
                                                              widget
                                                                  .pendingInvoice
                                                                  .removeWhere((item) =>
                                                                      item.sId ==
                                                                      widget
                                                                          .fullDetails
                                                                          .sId);
                                                              widget
                                                                  .pendingInvoice
                                                                  .add(widget
                                                                      .fullDetails);
                                                              widget
                                                                  .rebuildHomeScreen();
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                            // Navigator.pop(
                                                            //     context);
                                                            // Navigator.of(context);

                                                            // Navigator.pushNamed(
                                                            //     context,
                                                            //     cnInvoices);
                                                          },
                                                          child: Container(
                                                            height: h1p * 8,
                                                            width: w10p * 7.5,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color: Colours
                                                                    .pumpkin),
                                                            child: const Center(
                                                                child: Text(
                                                              "Accept",
                                                              style: TextStyles
                                                                  .subHeading,
                                                            )),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )).then((value) async {
                                          String? id =
                                              getIt<SharedPreferences>()
                                                  .getString('companyId');
                                          Provider.of<TransactionManager>(
                                                  context,
                                                  listen: false)
                                              .getInetialInvoices(
                                                  id: id,
                                                  resetConfirmedInvoices: true);
                                          // if (refreshingMethod != null) {
                                          //   refreshingMethod!();
                                          // }
                                        });
                                    },
                                    child: Container(
                                      height: h1p * 9,
                                      decoration: BoxDecoration(
                                          color: Colours.successPrimary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Text(
                                          "Accept",
                                          style: TextStyles.textStyle46,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      );
    }));
  }
}


