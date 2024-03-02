import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// import 'package:xuriti/logic/view_models/transaction_manager.dart';
// import 'package:xuriti/models/core/invoice_model.dart';
// import 'package:xuriti/ui/routes/router.dart';
// import 'package:xuriti/ui/screens/invoices_screens/all_sellers_screens/sellers_details.dart';
// import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/all_pending_invoices.dart';
// import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/dayleft_invoices.dart';
// import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/dayout_invoices.dart';
// import 'package:xuriti/ui/screens/invoices_screens/pending_invoices_screen/pending_invoice_report.dart';
// import 'package:xuriti/ui/theme/constants.dart';
// import 'package:xuriti/ui/widgets/download_report_widget.dart';
// import 'package:xuriti/ui/widgets/pending_invoices_widget/pending_invoice_widget.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/ui/widgets/pending_invoices_widget/pending_invoice_widget.dart';

import '../../../../logic/view_models/auth_manager.dart';
import '../../../../models/core/credit_limit_model.dart';
import '../../../theme/constants.dart';
import '../../../widgets/cn_invoice_widgets/paid_cn_widget.dart';
import '../../../widgets/cn_invoice_widgets/pending_cn_widget.dart';

class CNInvoices extends StatefulWidget {
  const CNInvoices({
    Key? key,
    this.refreshingFunction,
    required this.rebuildHomeScreen,
  }) : super(key: key);
  final Function? refreshingFunction;
  final Function rebuildHomeScreen;
  @override
  State<CNInvoices> createState() => _CNInvoicesState();
}

class _CNInvoicesState extends State<CNInvoices> {
  Invoice pendingCN = Invoice();
  Invoice otherCN = Invoice();
  List allcnInv = [];

  @override
  Widget build(BuildContext context) {
    List<Invoice> cnInvoices =
        Provider.of<TransactionManager>(context).cnInvoice;
    //print('cn invoices+++++++++++++++++++++++ ${cnInvoices[0].discount}');

    List<Invoice> pendingInvoices = cnInvoices
        .where((element) => element.invoiceStatus == "Pending")
        .toList();

    List<Invoice> otherInvoices = cnInvoices
        .where((element) => element.invoiceStatus != "Pending")
        .toList();
    pendingInvoices.sort((Invoice inv1, Invoice inv2) {
      return DateTime.parse(inv2.invoiceDate ?? "")
          .compareTo(DateTime.parse(inv1.invoiceDate ?? ""));
    });
    otherInvoices.sort((Invoice inv1, Invoice inv2) {
      return DateTime.parse(inv2.invoiceDate ?? "")
          .compareTo(DateTime.parse(inv1.invoiceDate ?? ""));
    });

    cnInvoices = [];
    cnInvoices.addAll(pendingInvoices);
    cnInvoices.addAll(otherInvoices);

    // if (cnInvoices.isNotEmpty) {
    //   cnInvoices.sort((b, a) {
    //     String newA = a.invoiceDate ?? '';
    //     String newB = b.invoiceDate ?? '';
    //     DateTime dtA = DateTime.parse(newA);
    //     DateTime dtB = DateTime.parse(newB);
    //     if (newA == '') {
    //       return 0;
    //     } else if (newB == '') {
    //       return 0;
    //     } else if (newA == '' && newB == '') {
    //       return 0;
    //     } else {
    //       return dtA.compareTo(dtB);
    //     }
    //   });
    // }

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Container(
              width: maxWidth,
              height: maxHeight,
              decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  )),
              child: cnInvoices.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: h1p * 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("All Credit Note Invoices",
                                  style: TextStyles.textStyle38),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Filters     ",
                              //       style: TextStyles.textStyle38,
                              //     ),
                              //     SvgPicture.asset("assets/images/filterRight.svg"),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: w10p * .6, vertical: h1p * 1),
                          child: Container(
                              width: maxWidth,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colours.offWhite),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: h1p * 3, horizontal: w10p * .3),
                                child: Row(children: [
                                  SvgPicture.asset("assets/images/logo1.svg"),
                                  SizedBox(
                                    width: w10p * 0.5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Text(
                                                  "No Credit Note invoices available",
                                                  style: TextStyles.textStyle34,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            "",
                                            style: TextStyles.textStyle34,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                              )),
                        ),
                        SizedBox(
                          height: h1p * 8,
                        ),
                        Center(
                          child:
                              Image.asset("assets/images/onboard-image-3.png"),
                        ),
                      ],
                    )
                  : CustomScrollView(
                      slivers: [
                        // SliverToBoxAdapter(
                        //   child:DownloadReport(maxHeight: maxHeight,maxWidth: maxWidth,),
                        //
                        // ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: h1p * 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("All Credit Note Invoices",
                                    style: TextStyles.textStyle38),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Filters     ",
                                //       style: TextStyles.textStyle38,
                                //     ),
                                //     SvgPicture.asset("assets/images/filterRight.svg"),
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                            delegate: SliverChildBuilderDelegate(
                          ((context, index) {
                            Buyer? seller = cnInvoices[index].seller;

                            return PendingCNInvoiceWidget(
                                refreshingMethod: widget.refreshingFunction,
                                maxWidth: maxWidth,
                                maxHeight: maxHeight,
                                amount: cnInvoices[index]
                                    .outstandingAmount
                                    .toString(),
                                invoiceDate:
                                    cnInvoices[index].invoiceDate ?? "",
                                dueDate: cnInvoices[index].invoiceDueDate ?? "",
                                companyName: seller?.companyName ?? "",
                                savedAmount: "500",
                                isOverdue: false,
                                index: index,
                                fullDetails: cnInvoices[index],
                                rebuildHomeScreen: widget.rebuildHomeScreen);
                          }),
                          childCount: cnInvoices.length,
                        )),
                      ],
                    )));
    });
  }
}

enum InvoiceStatus {
  Confirmed,
  Partpay,

  Rejected,

  Settled,
  Pending
}

class CNInvoice {
  String id;
  InvoiceStatus status;
  CNInvoice({required this.id, required this.status});
}
