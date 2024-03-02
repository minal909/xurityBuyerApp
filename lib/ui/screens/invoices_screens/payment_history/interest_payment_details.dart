import 'package:flutter/material.dart';
import 'package:xuriti/ui/widgets/profile/profile_widget.dart';




import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/bill_details.dart';
import '../../../widgets/payment_history_widgets/invoice_due.dart';
import '../../../widgets/payment_history_widgets/invoice_id.dart';
import '../../../widgets/payment_history_widgets/invoiceamt_dueamt.dart';
import '../../../widgets/payment_history_widgets/invoiceamt_savedamt.dart';
import '../../../widgets/payment_history_widgets/leading.dart';

class InterestPaymentDetails extends StatefulWidget {
  const InterestPaymentDetails({Key? key}) : super(key: key);

  @override
  State<InterestPaymentDetails> createState() => _InterestPaymentDetailsState();
}

class _InterestPaymentDetailsState extends State<InterestPaymentDetails> {
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
            flexibleSpace:  ProfileWidget(pskey: ssk),
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
                LeadingWidget(heading: "Back", ),
                // CompanyDetailsWidget(
                //   maxHeight: maxHeight,
                //   maxWidth: maxWidth,
                //   image: "assets/images/nippon-logo.png",
                //   companyName: "Nippon Paint",
                //   creditLimit: "Credit Limit : ₹ 98,000",
                // ),
                const InvoiceId(),
                InvoiceDueDateWidget(maxWidth: maxWidth,maxHeight: maxHeight,invoiceDate:"12.Jun.2022",companyName: "Company Name",dueDate: "28.Jun.2022",companyNameDue: "Company Name",),

                const InvoiceSavedAmtWidget(
                  heading1: "12,890",
                  heading2: "Interest Charged",
                  heading3: "₹ 500",
                  boolValue: true,
                ),
                const InvoiceamtWidget(
                  heading1: "13,390",
                  heading2: "12.Aug.2022",
                ),
                BillDetailsWidget(
                    maxHeight: maxHeight,
                    maxWidth: maxWidth,
                    heading: "Invoice Details"),
                SizedBox(
                  height: h10p * 3,
                )
              ])));
    });
  }
}
