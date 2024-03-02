import 'package:flutter/material.dart';

import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/bill_details.dart';
import '../../../widgets/payment_history_widgets/invoice_due.dart';
import '../../../widgets/payment_history_widgets/invoice_id.dart';
import '../../../widgets/payment_history_widgets/invoiceamt_dueamt.dart';
import '../../../widgets/payment_history_widgets/invoiceamt_savedamt.dart';
import '../../../widgets/payment_history_widgets/leading.dart';
import '../../../widgets/profile/profile_widget.dart';

class PendingInvoiceReport extends StatefulWidget {
  const PendingInvoiceReport({Key? key}) : super(key: key);

  @override
  State<PendingInvoiceReport> createState() => _PendingInvoiceReportState();
}

class _PendingInvoiceReportState extends State<PendingInvoiceReport> {
  GlobalKey<ScaffoldState> ssk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
          key: ssk,
          backgroundColor: Colours.black,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * 1.7,
            flexibleSpace: ProfileWidget(pskey: ssk),
          ),
          body: Container(
              width: maxWidth,
              height: maxHeight,
              decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  )),
              child: ListView(children: [
                LeadingWidget(
                  heading: "Back",
                ),
                // CompanyDetailsWidget(
                //   maxHeight: maxHeight,
                //   maxWidth: maxWidth,
                //   image: "assets/images/nippon-logo.png",
                //   companyName: "Nippon Paint",
                //   creditLimit: "Credit Limit : ₹ 98,000",
                // ),
                const InvoiceId(),
                InvoiceDueDateWidget(
                  maxWidth: maxWidth,
                  maxHeight: maxHeight,
                  invoiceDate: "12.Jun.2022",
                  companyName: "Company Name",
                  dueDate: "28.Jun.2022",
                  companyNameDue: "Company Name",
                ),
                const InvoiceSavedAmtWidget(
                  heading1: "11,800",
                  heading2: "You Saved",
                  heading3: "₹ 545",
                  boolValue: false,
                ),
                const InvoiceamtWidget(
                  heading1: "12,345",
                  heading2: "18.Jun.2022",
                ),
                BillDetailsWidget(
                    maxHeight: maxHeight,
                    maxWidth: maxWidth,
                    heading: "Bill Details"),
              ])));
    });
  }
}
