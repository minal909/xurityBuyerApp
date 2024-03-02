import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/invoice_model.dart';

import '../../../../logic/view_models/transaction_manager.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../../models/services/dio_service.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/company_details.dart';
import '../../../widgets/profile/notificationProfileWidget.dart';
import '../../../widgets/profile/profile_widget.dart';

class UpcomingDetails extends StatefulWidget {
  UpcomingDetails({Key? key}) : super(key: key);

  @override
  State<UpcomingDetails> createState() => _UpcomingDetailsState();
}

class _UpcomingDetailsState extends State<UpcomingDetails> {
  var invoice;
  var invoicedata;
  bool checkid = false;
  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    final PNinvId = getIt<SharedPreferences>().getString('targetid');
    final checkid = getIt<SharedPreferences>().getBool('checkId');
    this.checkid = checkid!;
  }

  @override
  Widget build(BuildContext context) {
    Invoice? invoicedata =
        Provider.of<TransactionManager>(context).currentInvoice;

    double? gstAmt;
    // MoneyFormatter gstamount = MoneyFormatter(amount: gstAmt!);

    // MoneyFormatterOutput GSTamt = gstamount.output;
    String? intrPaid =
        getIt<SharedPreferences>().getString('paidintr').toString();

    var interest = checkid ? intrPaid : invoicedata?.interest ?? 0;

    // invoiced.paidInterest;
    String intrst = interest.toString();

    double intrstt = double.parse(intrst);
    MoneyFormatter intamt = MoneyFormatter(amount: intrstt);

    MoneyFormatterOutput theinterest = intamt.output;

    // double intrst = double.parse(interest);
    String? paidDisc = getIt<SharedPreferences>().getString('paidDisc');
    String invno = getIt<SharedPreferences>().getString('invno').toString();
    String invst = getIt<SharedPreferences>().getString('invstatus').toString();

    var discount = checkid ? paidDisc : invoicedata?.discount ?? 0;
    // invoiced.paidDiscount;
    // invoice?.discount ?? 0;
    String strdscnt = discount.toString();
    double dbldscnt = double.parse(strdscnt);
    MoneyFormatter discont = MoneyFormatter(amount: dbldscnt);

    MoneyFormatterOutput discAmt = discont.output;
    print('inv date rsponse ${invoicedata?.invoiceDate}');

    String id = checkid
        ? getIt<SharedPreferences>().getString('invDate').toString()
        : (invoicedata?.invoiceDate ?? '');
    checkid
        ? print('date format value after normal navigation .............$id')
        : print(
            'date format value after notification navigation .............$id');

    //  (invoice?.invoiceDate ?? '');
    // var dateFromServer = id.replaceAll("-", " ");
    // print('invoice datet $id');

    DateTime invdt = DateTime.parse(id).toLocal();

    DateTime dd = checkid
        ? DateTime.parse(
                getIt<SharedPreferences>().getString('duedate').toString())
            .toLocal()
        : DateTime.parse(invoicedata?.invoiceDueDate ?? '').toLocal();
    // invoice?.invoiceDueDate ?? ''

    String idueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(invdt);

    DateTime currentDate = DateTime.now();
    Duration dif = dd.difference(currentDate);
    int daysLeft = dif.inDays;

    double outstandingAmt = checkid
        ? double.parse(
            getIt<SharedPreferences>().getString('outstanding').toString())
        : double.parse(invoicedata?.outstandingAmount ?? ""
            // invoice?.outstandingAmount ?? ""
            );
    MoneyFormatter outamt = MoneyFormatter(amount: outstandingAmt);

    MoneyFormatterOutput outstandAmt = outamt.output;

    double invAmt = checkid
        ? double.parse(
            getIt<SharedPreferences>().getString('inv_amt').toString()

            // invoice?.invoiceAmount ?? ""
            )
        : double.parse(invoicedata?.invoiceAmount ?? "");
    MoneyFormatter amtinv = MoneyFormatter(amount: invAmt);

    MoneyFormatterOutput invoiceAmt = amtinv.output;

    if (checkid
        ? getIt<SharedPreferences>().getString('undefined').toString() !=
            "undefined"
        : invoicedata?.billDetails?.gstSummary?.totalTax != "undefined") {
      String valBill =
          getIt<SharedPreferences>().getString('billValue').toString();

      gstAmt = checkid
          ? double.tryParse(
              getIt<SharedPreferences>().getString('billValue') ?? "0")!
          : double.tryParse(
              invoicedata?.billDetails?.gstSummary?.totalTax ?? "0")!;
    } else {
      gstAmt = 0;
    }

    String crdlmt = getIt<SharedPreferences>().getString('crdLimit').toString();

    dynamic creditLimit =
        checkid ? double.parse(crdlmt).toStringAsFixed(2) : null;

    String aCredit =
        getIt<SharedPreferences>().getString('availLimit').toString();

    dynamic availCrd =
        checkid ? double.parse(aCredit).toStringAsFixed(2) : null;

    double gstgst = gstAmt;
    MoneyFormatter totalgst = MoneyFormatter(amount: gstgst);

    MoneyFormatterOutput invgst = totalgst.output;

    double totalInvoiceAmount = invAmt + gstAmt;
    MoneyFormatter totalamt = MoneyFormatter(amount: totalInvoiceAmount);

    MoneyFormatterOutput invAmtTotal = totalamt.output;

    double totalAmtPaid = totalInvoiceAmount - outstandingAmt;
    double totalAmtInAbs = totalAmtPaid.abs();
    MoneyFormatter absAmt = MoneyFormatter(amount: totalAmtInAbs);

    MoneyFormatterOutput totalAbsAmt = absAmt.output;

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
            flexibleSpace: checkid
                ? NotificationProfile(creditLimit, availCrd)
                : ProfileWidget(),
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
                padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 13),
                      child: GestureDetector(
                        onTap: () {
                          checkid
                              ? Navigator.pushNamed(context, oktWrapper)
                              : Navigator.pop(context);
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
                      companyName: checkid
                          ? getIt<SharedPreferences>()
                              .getString('companyName')
                              .toString()
                          : invoicedata?.seller!.companyName ?? '',
                      // fullDetail.seller!.companyName ?? '',
                      companyAddress: checkid
                          ? getIt<SharedPreferences>()
                              .getString('address')
                              .toString()
                          : invoicedata?.seller!.address ?? '',
                      // fullDetail.seller!.address ?? '',
                      state: checkid
                          ? getIt<SharedPreferences>()
                              .getString('state')
                              .toString()
                          : invoicedata?.seller!.state ?? '',
                      // fullDetail.seller!.state ?? '',
                      gstNo: checkid
                          ? getIt<SharedPreferences>()
                              .getString('gstin')
                              .toString()
                          : invoicedata?.seller!.gstin ?? '',
                      // fullDetail.seller!.gstin ?? '',
                      creditLimit: checkid
                          ? crdlmt
                          : invoicedata?.buyer!.creditLimit ?? '',

                      balanceCredit: checkid
                          ? aCredit
                          : invoicedata?.buyer!.availCredit ?? '',
                    ),
                    SizedBox(height: h1p * 2),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        height: h1p * 11,
                        width: w10p * 3,
                        decoration: BoxDecoration(
                          color: Colours.pearlGrey,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w10p * .27, vertical: h1p * 1.5),
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
                                    checkid
                                        ? "${invno}"
                                        : "${invoicedata?.invoiceNumber}",
                                    style: TextStyles.textStyle56,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Invoice Status",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    checkid
                                        ? "${invst}"
                                        : "${invoicedata?.invoiceStatus}",
                                    style: TextStyles.textStyle63,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Outstanding Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${outstandAmt.nonSymbol}",
                                    style: TextStyles.textStyleC85,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text(
                      // " Payments Pending since 10 days",
                      currentDate.isAfter(dd)
                          ? " ${currentDate.difference(dd).inDays.toString()} days overdue"
                          : " Due since ${currentDate.difference(invdt).inDays.toString()} days",
                      //" ${daysLeft.toString()} days left",
                      style: TextStyles.textStyle57,
                      textAlign: TextAlign.center,
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
                                  //        invoice.seller!.companyName ?? '',
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
                      padding: EdgeInsets.symmetric(horizontal: w10p * .5),
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
                                    "₹ ${invoiceAmt.nonSymbol}",
                                    style: TextStyles.textStyle65,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Total Invoice Amt",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ ${invAmtTotal.nonSymbol}",
                                    style: TextStyles.textStyle66,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h1p * 1,
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w10p * .5),
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
                                      "Interest",
                                      style: TextStyles.textStyle62,
                                    ),
                                    Text(
                                      "₹ ${theinterest.nonSymbol}",
                                      style: TextStyles.textStyle142,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Discount",
                                      style: TextStyles.textStyle62,
                                    ),
                                    Text(
                                      "₹ ${discAmt.nonSymbol}",
                                      style: TextStyles.textStyle143,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h1p * 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h1p * 1,
                    ),
                    Card(
                      elevation: .5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w10p * .5),
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
                                      "GST Amount",
                                      style: TextStyles.textStyle62,
                                    ),
                                    Text(
                                      "₹ ${invgst.nonSymbol}",
                                      style: TextStyles.textStyle65,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "Amount Paid",
                                      style: TextStyles.textStyle62,
                                    ),
                                    Text(
                                      "₹ ${totalAbsAmt.nonSymbol}",
                                      style: TextStyles.textStyle66,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h1p * 2,
                            ),
                          ],
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
                              if (invoicedata!.invoiceFile!.isNotEmpty) {
                                await getIt<TransactionManager>()
                                    .openFile(url: invoice!.invoiceFile ?? "");
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
                            child:
                                Image.asset("assets/images/invoiceButton.png")),
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
