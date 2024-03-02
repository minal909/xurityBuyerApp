import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/widgets/pending_invoices_widget/pending_invoice_widget.dart';

import '../../../theme/constants.dart';

class PInvoices extends StatefulWidget {
  const PInvoices({Key? key, this.refreshingFunction}) : super(key: key);
  final Function? refreshingFunction;
  @override
  State<PInvoices> createState() => _PInvoicesState();
}

class _PInvoicesState extends State<PInvoices> {
  bool callScroll = true;
  bool hasMoreItemsToScroll = true;
  ScrollController controllerForScroll = new ScrollController();

  @override
  void initState() {
    String? id = getIt<SharedPreferences>().getString('companyId');
    controllerForScroll.addListener(() async {
      if (controllerForScroll.offset >
              controllerForScroll.position.maxScrollExtent - 100 &&
          callScroll) {
        callScroll = false;
        hasMoreItemsToScroll =
            await Provider.of<TransactionManager>(context, listen: false)
                .addInvoices(id: id, status: 'Pending');
        callScroll = hasMoreItemsToScroll;
        setState(() {
          hasMoreItemsToScroll = hasMoreItemsToScroll;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Invoice> pendingInvoice =
        Provider.of<TransactionManager>(context).pendingInvoice;
    if (pendingInvoice.length < 5) {
      hasMoreItemsToScroll = false;
    }
    // if (pendingInvoice.isNotEmpty) {
    //   pendingInvoice.sort((b, a) {
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
              child: pendingInvoice.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: h1p * 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("All Pending Invoices",
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
                                                  "No pending invoice available",
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
                      controller: controllerForScroll,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18, vertical: h1p * 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("All Pending Invoices",
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
                            Buyer? seller = pendingInvoice[index].seller;
                            return PendingInvoiceWidget(
                              refreshingMethod: widget.refreshingFunction,
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              amount: pendingInvoice[index]
                                  .outstandingAmount
                                  .toString(),
                              invoiceDate:
                                  pendingInvoice[index].invoiceDate ?? "",
                              dueDate:
                                  pendingInvoice[index].invoiceDueDate ?? "",
                              companyName: seller?.companyName ?? "",
                              savedAmount: "500",
                              isOverdue: false,
                              index: index,
                              fullDetails: pendingInvoice[index],
                            );
                          }),
                          childCount: pendingInvoice.length,
                        )),
                        SliverToBoxAdapter(
                          child: hasMoreItemsToScroll
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  'no more invoices',
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ],
                    )));
    });
  }
}
