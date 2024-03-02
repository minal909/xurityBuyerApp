import 'package:flutter/material.dart';
import 'package:xuriti/ui/routes/router.dart';

import '../../../theme/constants.dart';
import '../../../widgets/all_sellers_screen_widgets/closed_saved_widget.dart';
import '../../../widgets/payment_history_widgets/invoice_due.dart';
import '../../../widgets/payment_history_widgets/invoiceamt_dueamt.dart';
import '../../../widgets/payment_history_widgets/invoiceamt_savedamt.dart';



class SavedPayment extends StatelessWidget {
  const SavedPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return ExpansionTile(
        tilePadding: const EdgeInsets.only(
          left: 15,
          top: 25,
        ),
        trailing: Container(
          width: w10p * .001,
          height: h1p * .001,
          decoration: BoxDecoration(border: Border.all(color: Colours.white)),
        ),
        title:

        ClosedSavedWidget(maxWidth: maxWidth, maxHeight: maxHeight, amount:  "12,345", day: "30.Aug.2022",SAmount: "545",companyName: "Nippon Paint"),

        children: [
          InvoiceDueDateWidget(maxWidth: maxWidth,maxHeight: maxHeight,invoiceDate:"12.Jun.2022",companyName: "Nippon Paint",dueDate: "28.Jun.2022",companyNameDue: "Nippon Paint",),
          const InvoiceSavedAmtWidget(heading1: "12,345",heading2: "You Saved",heading3: "₹ 545",boolValue: false,),
          const InvoiceamtWidget(heading1:"11,800",heading2: "18.Jun.2022"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Coupon Discount : XUR2OFF",style: TextStyles.textStyle62,),
                    Text("₹ 500",style: TextStyles.textStyle56,),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, savedPaymentDetails);
                  },
                    child: Image.asset("assets/images/phistory_viewfulldetails.png")),
              ],
            ),
          ),
           SizedBox(height: 10,)

        ],
      );
    });
  }
}
