// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_progress_hud/flutter_progress_hud.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:money_formatter/money_formatter.dart';
// import 'package:xuriti/logic/view_models/auth_manager.dart';
// import 'package:xuriti/util/loaderWidget.dart';
// import '../../../logic/view_models/transaction_manager.dart';
// import '../../../models/core/invoice_model.dart';
// import '../../../models/helper/service_locator.dart';
// import '../../routes/router.dart';
// import '../../theme/constants.dart';

// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   print("onBackgroundMessage: $message");
// // }

// class PendingInvoiceWidget extends StatefulWidget {
//   final double maxWidth;
//   final Function? refreshingMethod;
//   final double maxHeight;
//   final bool isOverdue;
//   final String amount;
//   final String savedAmount;
//   final String invoiceDate;
//   final String dueDate;
//   Invoice fullDetails;
//   int index;
//   final String companyName;
//   PendingInvoiceWidget(
//       {required this.fullDetails,
//       required this.maxWidth,
//       required this.maxHeight,
//       required this.amount,
//       required this.savedAmount,
//       required this.index,
//       required this.invoiceDate,
//       required this.dueDate,
//       required this.companyName,
//       required this.isOverdue,
//       required this.refreshingMethod});

//   @override
//   State<PendingInvoiceWidget> createState() => _PendingInvoiceWidgetState();
// }

// class _PendingInvoiceWidgetState extends State<PendingInvoiceWidget> {
//   bool userConsentGiven = false;

//   List<Invoice> pendingInvoice = [];

//   // @override
//   // void initState() {
//   //   init();
//   //   super.initState();
//   // }

//   // Future init() async {
//   //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//   //     print("onMessage: $message");
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController acceptController = TextEditingController();
//     TextEditingController rejectController = TextEditingController();

//     String? invoiceId = widget.fullDetails.sId;
//     double invAmt = double.parse(widget.amount);
//     MoneyFormatter fmf = MoneyFormatter(amount: invAmt);

//     MoneyFormatterOutput invamount = fmf.output;

//     DateTime id = DateTime.parse(widget.invoiceDate);
//     DateTime dd = DateTime.parse(widget.dueDate);
//     DateTime currentDate = DateTime.now();
//     Duration dif = dd.difference(currentDate);
//     int daysLeft = dif.inDays;
//     String idueDate = DateFormat("dd-MMM-yyyy").format(dd);
//     String invDate = DateFormat("dd-MMM-yyyy").format(id);

//     double h1p = widget.maxHeight * 0.01;
//     double h10p = widget.maxHeight * 0.1;
//     double w10p = widget.maxWidth * 0.1;

//     return ProgressHUD(child: Builder(builder: (context) {
//       final progress = ProgressHUD.of(context);
//       return ExpandableNotifier(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
//           child: Expandable(
//               collapsed: ExpandableButton(
//                 child: Card(
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colours.offWhite
//                         // color: fullDetails.invoiceType == "IN"
//                         //     ? Colours.offWhite
//                         //     : Color(0xfffcdcb4),
//                         ),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               widget.isOverdue
//                                   ? Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: h1p * 1),
//                                       child: Container(
//                                         // height: h1p * 4.5,
//                                         // width: w10p * 1.7,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: Colours.failPrimary,
//                                         ),
//                                         child: const Center(
//                                           child: Padding(
//                                             padding: EdgeInsets.all(4),
//                                             child: Text(
//                                               "Overdue",
//                                               style: TextStyles.overdue,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),

//                               Row(
//                                 children: [
//                                   Text(
//                                     "${widget.fullDetails.invoiceNumber}",
//                                     style: TextStyles.textStyle6,
//                                   ),
//                                   SvgPicture.asset(
//                                       "assets/images/home_images/arrow-circle-right.svg"),
//                                 ],
//                               ),

//                               SizedBox(
//                                 width: 100.0,
//                                 height: 30.0,
//                                 child: AutoSizeText(
//                                   widget.companyName,
//                                   maxLines: 1,
//                                   style: TextStyles.companyName,
//                                 ),
//                               ),
//                               // isOverdue?
//                               // const Text(
//                               //   "interest charged",
//                               //   style: TextStyles.textStyle102,
//                               // ):
//                               // // const Text(
//                               // //  "You Save",
//                               // //   style: TextStyles.textStyle102,
//                               // // ),
//                               // Text(
//                               //   "₹ $savedAmount",
//                               //  style: isOverdue?
//                               //  TextStyles.textStyle61 :
//                               //   TextStyles.textStyle100,
//                               // )
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 currentDate.isAfter(dd)
//                                     ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
//                                     : " Due since ${currentDate.difference(id).inDays.toString()} days",
//                                 style: TextStyles.textStyle57,
//                               ),
//                               Text(
//                                 "₹ ${invamount.nonSymbol}",
//                                 style: TextStyles.textStyle58,
//                               ),
//                             ],
//                           )
//                         ]),
//                   ),
//                 ),
//               ),
//               expanded: Column(
//                 children: [
//                   ExpandableButton(
//                     child: Card(
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colours.offWhite,
//                         ),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   widget.isOverdue
//                                       ? Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               vertical: h1p * 1),
//                                           child: Container(
//                                             // height: h1p * 4.4,
//                                             // width: w10p * 1.7,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               color: Colours.failPrimary,
//                                             ),
//                                             child: const Center(
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(3.5),
//                                                 child: Text(
//                                                   "Overdue",
//                                                   style: TextStyles.overdue,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Container(),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "${widget.fullDetails.invoiceNumber}",
//                                         style: TextStyles.textStyle6,
//                                       ),
//                                       SvgPicture.asset(
//                                           "assets/images/home_images/rightArrow.svg"),
//                                     ],
//                                   ),

//                                   SizedBox(
//                                     width: 100.0,
//                                     height: 30.0,
//                                     child: AutoSizeText(
//                                       widget.companyName,
//                                       maxLines: 1,
//                                       style: TextStyles.companyName,
//                                     ),
//                                   ),

//                                   // Text(
//                                   //   widget.companyName,
//                                   //   style: TextStyles.companyName,
//                                   // ),
//                                   // // isOverdue? const Text(
//                                   //   "Interest charged",
//                                   //   style: TextStyles.textStyle102,
//                                   // ):
//                                   // Text(
//                                   //   "You Save",
//                                   //   style: TextStyles.textStyle102,
//                                   // ),
//                                   // Text(
//                                   //   "₹ $savedAmount",
//                                   //   style:isOverdue?
//                                   //   TextStyles.textStyle61:
//                                   //   TextStyles.textStyle100,
//                                   // )
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     currentDate.isAfter(dd)
//                                         ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
//                                         : " Due since ${currentDate.difference(id).inDays.toString()} days",
//                                     style: TextStyles.textStyle57,
//                                   ),
//                                   Text(
//                                     "₹ ${invamount.nonSymbol}",
//                                     style: TextStyles.textStyle58,
//                                   ),
//                                 ],
//                               )
//                             ]),
//                       ),
//                     ),
//                   ),
//                   Card(
//                     elevation: .5,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               const Text(
//                                 "Invoice Date",
//                                 style: TextStyles.textStyle62,
//                               ),
//                               Text(
//                                 invDate,
//                                 style: TextStyles.textStyle63,
//                               ),
//                               // Text(
//                               //   companyName,
//                               //   style: TextStyles.companyName,
//                               // ),
//                             ],
//                           ),
//                           SvgPicture.asset("assets/images/arrow.svg"),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               const SizedBox(
//                                 height: 4,
//                               ),
//                               const Text(
//                                 "Due Date",
//                                 style: TextStyles.textStyle62,
//                               ),
//                               Text(
//                                 idueDate,
//                                 style: TextStyles.textStyle63,
//                               ),
//                               // Text(
//                               //  companyName,
//                               //   style: TextStyles.companyName,
//                               // ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Card(
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: const BoxDecoration(),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(
//                                     height: 4,
//                                   ),
//                                   const Text(
//                                     "Invoice Amount",
//                                     style: TextStyles.textStyle62,
//                                   ),
//                                   Text(
//                                     "₹ ${invamount.nonSymbol}",
//                                     style: TextStyles.textStyle65,
//                                   )
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   const SizedBox(
//                                     height: 4,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: h1p * 1.5,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                             child: GestureDetector(
//                                 onTap: () {
//                                   getIt<TransactionManager>()
//                                       .changeSelectedInvoice(
//                                           widget.fullDetails);
//                                   Navigator.pushNamed(context, savemoreDetails);
//                                 },
//                                 child: Container(
//                                   width: 300,
//                                   height: 40,
//                                   child: Center(
//                                       child: Text(
//                                     "View Details",
//                                     style: TextStyles.textStyle195,
//                                   )),
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(5)),
//                                     color: Colours.pumpkin,
//                                   ),
//                                 )),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: InkWell(
//                                   onTap: () async {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) => Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       // vertical: h10p * 5,
//                                                       ),
//                                               child: AlertDialog(
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     10.0))),
//                                                 title: Row(
//                                                   children: const [
//                                                     Center(
//                                                       child: Text("Comment"),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 content: Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     TextField(
//                                                       controller:
//                                                           rejectController,
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               hintText:
//                                                                   "Leave a comment *"),
//                                                       onChanged: (_) {
//                                                         acceptController
//                                                                 .text.isEmpty
//                                                             ? Row(
//                                                                 children: const [
//                                                                   Text(
//                                                                     "Please write a reason",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .red),
//                                                                   ),
//                                                                 ],
//                                                               )
//                                                             : Container();
//                                                       },
//                                                     ),
//                                                     SizedBox(
//                                                       height: h1p * 5,
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () async {
//                                                         if (rejectController
//                                                             .text.isNotEmpty) {
//                                                           userConsentGiven =
//                                                               false;
//                                                           String timeStamp =
//                                                               DateTime.now()
//                                                                   .toString();
//                                                           context.showLoader();
//                                                           // progress!.show();
//                                                           print(acceptController
//                                                               .text);
//                                                           String message = await getIt<
//                                                                   TransactionManager>()
//                                                               .changeInvoiceStatus(
//                                                                   invoiceId,
//                                                                   "Rejected",
//                                                                   widget.index,
//                                                                   widget
//                                                                       .fullDetails,
//                                                                   timeStamp,
//                                                                   userConsentGiven,
//                                                                   acceptController
//                                                                       .text,
//                                                                   "NA");
//                                                           // progress.dismiss();
//                                                           context.hideLoader();
//                                                           ScaffoldMessenger.of(
//                                                                   context)
//                                                               .showSnackBar(
//                                                                   SnackBar(
//                                                                       behavior:
//                                                                           SnackBarBehavior
//                                                                               .floating,
//                                                                       content:
//                                                                           Text(
//                                                                         message,
//                                                                         style: const TextStyle(
//                                                                             color:
//                                                                                 Colors.red),
//                                                                       )));
//                                                           Navigator.pop(
//                                                               context);
//                                                         } else {
//                                                           Fluttertoast.showToast(
//                                                               msg:
//                                                                   "Please write a reason",
//                                                               textColor:
//                                                                   Colors.red);
//                                                         }
//                                                       },
//                                                       child: Container(
//                                                         height: h1p * 8,
//                                                         width: w10p * 7.5,
//                                                         decoration: BoxDecoration(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         6),
//                                                             color: Colours
//                                                                 .pumpkin),
//                                                         child: const Center(
//                                                             child: Text(
//                                                           "Save",
//                                                           style: TextStyles
//                                                               .subHeading,
//                                                         )),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ));
//                                   },
//                                   child: Container(
//                                     height: h1p * 9,
//                                     decoration: BoxDecoration(
//                                         color: Colours.failPrimary,
//                                         borderRadius: BorderRadius.circular(5)),
//                                     child: const Center(
//                                       child: Text(
//                                         "Reject",
//                                         style: TextStyles.textStyle46,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Expanded(
//                                 child: InkWell(
//                                   onTap: () async {
//                                     showDialog(
//                                         context: context,
//                                         builder: (context) => Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       // vertical: h10p * 4,
//                                                       ),
//                                               child: AlertDialog(
//                                                 shape:
//                                                     const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     10.0))),
//                                                 title: const Center(
//                                                   child: Text("Consent"),
//                                                 ),
//                                                 content: Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     widget.fullDetails
//                                                                 .invoiceType ==
//                                                             "IN"
//                                                         ? Text(
//                                                             "I agree and  approve Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to disburse funds to the Seller ${widget.companyName} for invoice -${widget.fullDetails.invoiceNumber} on my behalf.")
//                                                         : Text(
//                                                             "I agree and approve that credit note ${widget.fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to ${widget.companyName}."),
//                                                     TextField(
//                                                       controller:
//                                                           acceptController,
//                                                       decoration:
//                                                           const InputDecoration(
//                                                               hintText:
//                                                                   "Leave a comment *"),
//                                                       onChanged: (_) {
//                                                         print(acceptController
//                                                             .text);
//                                                         acceptController
//                                                                 .text.isEmpty
//                                                             ? Row(
//                                                                 children: const [
//                                                                   Text(
//                                                                     "Please write a reason",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .red),
//                                                                   ),
//                                                                 ],
//                                                               )
//                                                             : Container();
//                                                       },
//                                                     ),
//                                                     SizedBox(
//                                                       height: h1p * 4,
//                                                     ),
//                                                     InkWell(
//                                                       onTap: () async {
//                                                         // final respData = await getIt<
//                                                         //         AuthManager>()
//                                                         //     .sendNotification();

//                                                         userConsentGiven = true;
//                                                         String timeStamp =
//                                                             DateTime.now()
//                                                                 .toString();
//                                                         if (acceptController
//                                                             .text.isNotEmpty) {
//                                                           // progress!.show();
//                                                           context.showLoader();

//                                                           String? message = await getIt<
//                                                                   TransactionManager>()
//                                                               .changeInvoiceStatus(
//                                                             invoiceId,
//                                                             "Confirmed",
//                                                             widget.index,
//                                                             widget.fullDetails,
//                                                             timeStamp,
//                                                             userConsentGiven,
//                                                             acceptController
//                                                                 .text,
//                                                             widget.fullDetails
//                                                                         .invoiceType ==
//                                                                     "IN"
//                                                                 ? "I agree and  approve Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to disburse funds to the Seller ${widget.companyName} for invoice -${widget.fullDetails.invoiceNumber} on my behalf."
//                                                                 : "I agree and approve that credit note ${widget.fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to ${widget.companyName}.",
//                                                           );
//                                                           //progress.dismiss();
//                                                           context.hideLoader();
//                                                           if (widget
//                                                                   .refreshingMethod !=
//                                                               null) {
//                                                             widget
//                                                                 .refreshingMethod!();
//                                                           }

//                                                           print(
//                                                               '${message} ====================>');
//                                                           ScaffoldMessenger.of(
//                                                                   context)
//                                                               .showSnackBar(
//                                                                   SnackBar(
//                                                                       behavior:
//                                                                           SnackBarBehavior
//                                                                               .floating,
//                                                                       content:
//                                                                           Text(
//                                                                         message!,
//                                                                         style: const TextStyle(
//                                                                             color:
//                                                                                 Colors.green),
//                                                                       )));
//                                                         } else {
//                                                           Fluttertoast.showToast(
//                                                               msg:
//                                                                   "Please write a reason",
//                                                               textColor:
//                                                                   Colors.red);
//                                                         }

//                                                         // Navigator.pop(context);
//                                                         // Navigator.of(context);

//                                                         Navigator.of(context)
//                                                             .pushNamed(
//                                                                 '/pInvoices');
//                                                       },
//                                                       child: Container(
//                                                         height: h1p * 8,
//                                                         width: w10p * 7.5,
//                                                         decoration: BoxDecoration(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         6),
//                                                             color: Colours
//                                                                 .pumpkin),
//                                                         child: const Center(
//                                                             child: Text(
//                                                           "Accept",
//                                                           style: TextStyles
//                                                               .subHeading,
//                                                         )),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ));
//                                   },
//                                   child: Container(
//                                     height: h1p * 9,
//                                     decoration: BoxDecoration(
//                                         color: Colours.successPrimary,
//                                         borderRadius: BorderRadius.circular(5)),
//                                     child: const Center(
//                                       child: Text(
//                                         "Accept",
//                                         style: TextStyles.textStyle46,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//         ),
//       );
//     }));
//   }
// }
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../models/helper/service_locator.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("onBackgroundMessage: $message");
// }

class PendingInvoiceWidget extends StatefulWidget {
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
  final String companyName;
  // final Function rebuildPendingScreen;
  PendingInvoiceWidget({
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
    required this.refreshingMethod,
    // required this.rebuildPendingScreen
  });

  @override
  State<PendingInvoiceWidget> createState() => _PendingInvoiceWidgetState();
}

class _PendingInvoiceWidgetState extends State<PendingInvoiceWidget> {
  bool userConsentGiven = false;

  List<Invoice> pendingInvoice = [];

  // @override
  // void initState() {
  //   init();
  //   super.initState();
  // }

  // Future init() async {
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     print("onMessage: $message");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController acceptController = TextEditingController();
    TextEditingController rejectController = TextEditingController();

    String? invoiceId = widget.fullDetails.sId;
    double invAmt = double.parse(widget.amount);
    MoneyFormatter fmf = MoneyFormatter(amount: invAmt);

    MoneyFormatterOutput invamount = fmf.output;

    DateTime id = DateTime.parse(widget.invoiceDate);
    DateTime dd = DateTime.parse(widget.dueDate);
    DateTime currentDate = DateTime.now();
    Duration dif = dd.difference(currentDate);
    int daysLeft = dif.inDays;
    String idueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(id);

    double h1p = widget.maxHeight * 0.01;
    double h10p = widget.maxHeight * 0.1;
    double w10p = widget.maxWidth * 0.1;

    return ProgressHUD(child: Builder(builder: (context) {
      final progress = ProgressHUD.of(context);
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
                              widget.isOverdue
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
                                  Text(
                                    "${widget.fullDetails.invoiceNumber}",
                                    style: TextStyles.textStyle6,
                                  ),
                                  SvgPicture.asset(
                                      "assets/images/home_images/arrow-circle-right.svg"),
                                ],
                              ),

                              SizedBox(
                                width: 100.0,
                                height: 30.0,
                                child: AutoSizeText(
                                  widget.companyName,
                                  maxLines: 1,
                                  style: TextStyles.companyName,
                                ),
                              ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                currentDate.isAfter(dd)
                                    ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                                    : " Due since ${currentDate.difference(id).inDays.toString()} days",
                                style: TextStyles.textStyle57,
                              ),
                              Text(
                                "₹ ${invamount.nonSymbol}",
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
                                  widget.isOverdue
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
                                        "${widget.fullDetails.invoiceNumber}",
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
                                      widget.companyName,
                                      maxLines: 1,
                                      style: TextStyles.companyName,
                                    ),
                                  ),

                                  // Text(
                                  //   widget.companyName,
                                  //   style: TextStyles.companyName,
                                  // ),
                                  // // isOverdue? const Text(
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
                                  Text(
                                    currentDate.isAfter(dd)
                                        ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                                        : " Due since ${currentDate.difference(id).inDays.toString()} days",
                                    style: TextStyles.textStyle57,
                                  ),
                                  Text(
                                    "₹ ${invamount.nonSymbol}",
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
                                    "Invoice Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${invamount.nonSymbol}",
                                    style: TextStyles.textStyle65,
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h1p * 1.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                                onTap: () {
                                  getIt<TransactionManager>()
                                      .changeSelectedInvoice(
                                          widget.fullDetails);
                                  Navigator.pushNamed(context, savemoreDetails);
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
                                                                        color: Colors
                                                                            .red),
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
                                                            .text.isNotEmpty) {
                                                          userConsentGiven =
                                                              false;
                                                          String timeStamp =
                                                              DateTime.now()
                                                                  .toString();
                                                          context.showLoader();
                                                          // progress!.show();
                                                          print(acceptController
                                                              .text);
                                                          String message = await getIt<
                                                                  TransactionManager>()
                                                              .changeInvoiceStatus(
                                                                  invoiceId,
                                                                  "Rejected",
                                                                  widget.index,
                                                                  widget
                                                                      .fullDetails,
                                                                  timeStamp,
                                                                  userConsentGiven,
                                                                  acceptController
                                                                      .text,
                                                                  "NA");
                                                          // progress.dismiss();
                                                          context.hideLoader();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      content:
                                                                          Text(
                                                                        message,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.red),
                                                                      )));
                                                          Navigator.pop(
                                                              context);
                                                          // Navigator.of(context);

                                                          // Navigator.of(context)
                                                          //     .pushNamed(
                                                          //         '/InvoiceScreen');
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
                                        borderRadius: BorderRadius.circular(5)),
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
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      // vertical: h10p * 4,
                                                      ),
                                              child: AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
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
                                                    widget.fullDetails
                                                                .invoiceType ==
                                                            "IN"
                                                        ? Text(
                                                            "I agree and  approve Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to disburse funds to the Seller ${widget.companyName} for invoice -${widget.fullDetails.invoiceNumber} on my behalf.")
                                                        : Text(
                                                            "I agree and approve that credit note ${widget.fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to ${widget.companyName}."),
                                                    TextField(
                                                      controller:
                                                          acceptController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Leave a comment *"),
                                                      onChanged: (_) {
                                                        print(acceptController
                                                            .text);
                                                        acceptController
                                                                .text.isEmpty
                                                            ? Row(
                                                                children: const [
                                                                  Text(
                                                                    "Please write a reason",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
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
                                                        // final respData = await getIt<
                                                        //         AuthManager>()
                                                        //     .sendNotification();

                                                        userConsentGiven = true;
                                                        String timeStamp =
                                                            DateTime.now()
                                                                .toString();
                                                        context.showLoader();
                                                        if (acceptController
                                                            .text.isNotEmpty) {
                                                          // progress!.show();
                                                          // context.showLoader();

                                                          String? message = await getIt<
                                                                  TransactionManager>()
                                                              .changeInvoiceStatus(
                                                            invoiceId,
                                                            "Confirmed",
                                                            widget.index,
                                                            widget.fullDetails,
                                                            timeStamp,
                                                            userConsentGiven,
                                                            acceptController
                                                                .text,
                                                            widget.fullDetails
                                                                        .invoiceType ==
                                                                    "IN"
                                                                ? "I agree and  approve Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to disburse funds to the Seller ${widget.companyName} for invoice -${widget.fullDetails.invoiceNumber} on my behalf."
                                                                : "I agree and approve that credit note ${widget.fullDetails.invoiceNumber} is correct. Xuriti and it's financing partner ${widget.fullDetails.nbfcName} is authorised to adjust the credit note amount towards the upcoming invoices and disburse the remaining balance to ${widget.companyName}.",
                                                          );
                                                          // Provider.of<TransactionManager>(
                                                          //         context)
                                                          //     .invoiceDispose();
                                                          //progress.dismiss();
                                                          // context.showLoader();

                                                          if (widget
                                                                  .refreshingMethod !=
                                                              null) {
                                                            widget
                                                                .refreshingMethod!();
                                                          }
                                                          context.hideLoader();
//
                                                          String? id = await getIt<
                                                                  SharedPreferences>()
                                                              .getString(
                                                                  'companyId');
                                                          // await Provider.of<
                                                          //             TransactionManager>(
                                                          //         context,
                                                          //         listen: false)
                                                          //     .getInetialInvoices(
                                                          //         id: id,
                                                          //         resetConfirmedInvoices:
                                                          //             true);

                                                          print(
                                                              '${message} ====================>');

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  SnackBar(
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      content:
                                                                          Text(
                                                                        message!,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.green),
                                                                      )));
                                                          Navigator.pop(
                                                              context);
                                                          await Provider.of<
                                                                      TransactionManager>(
                                                                  context,
                                                                  listen: false)
                                                              .invoiceDispose();
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please write a reason",
                                                              textColor:
                                                                  Colors.red);
                                                        }

                                                        // setState(() {
                                                        //   // widget.fullDetails
                                                        //   //         .invoiceStatus =
                                                        //   //     acceptController
                                                        //   //         .text;

                                                        //   // widget
                                                        //   //     .pendingInvoice
                                                        //   //     .removeWhere((item) =>
                                                        //   //         item.sId ==
                                                        //   //         widget
                                                        //   //             .fullDetails
                                                        //   //             .sId);
                                                        //   //     widget
                                                        //   //         .pendingInvoice
                                                        //   //         .add(widget
                                                        //   //             .fullDetails);
                                                        //   // Provider.of<TransactionManager>(
                                                        //   //         context)
                                                        //   //     .invoiceDispose();
                                                        //   // widget
                                                        //   //     .fullDetails.sId;
                                                        //   // widget
                                                        //   //     .rebuildPendingScreen();
                                                        //   Navigator.pop(
                                                        //       context);
                                                        // });

                                                        // Navigator.pop(context);
                                                        // Navigator.of(context);

                                                        // Navigator.of(context)
                                                        //     .pushNamed(
                                                        //         '/InvoiceScreen');
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
                                            ));
                                    //         .then((value) async {
                                    //   String? id = getIt<SharedPreferences>()
                                    //       .getString('companyId');

                                    //   Provider.of<TransactionManager>(context,
                                    //           listen: false)
                                    //       .getInetialInvoices(
                                    //           id: id,
                                    //           resetConfirmedInvoices: true);
                                    //   if (widget.refreshingMethod != null) {
                                    //     widget.refreshingMethod!();
                                    //   }
                                    // }
                                    // );
                                  },
                                  child: Container(
                                    height: h1p * 9,
                                    decoration: BoxDecoration(
                                        color: Colours.successPrimary,
                                        borderRadius: BorderRadius.circular(5)),
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
