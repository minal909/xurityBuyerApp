import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xuriti/ui/routes/router.dart';

import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/intrest_charged.dart';
import '../../../widgets/payment_history_widgets/invoice_due.dart';
import '../../../widgets/payment_history_widgets/invoiceamt_dueamt.dart';


class IntrestPayment extends StatefulWidget {
  const IntrestPayment({Key? key}) : super(key: key);

  @override
  State<IntrestPayment> createState() => _IntrestPaymentState();
}

class _IntrestPaymentState extends State<IntrestPayment> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return ExpansionTile(
        tilePadding: const EdgeInsets.only(
          left: 20,
          top: 25,
        ),
        trailing: Container(
          width: w10p * .001,
          height: h1p * .001,
          decoration: BoxDecoration(border: Border.all(color: Colours.white)),
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colours.offWhite,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("#4321",style: TextStyles.textStyle6,),
                          SvgPicture.asset("assets/images/home_images/rightArrow.svg"),
                        ],
                      ),
                      const Text(
                        "Company Name",
                        style: TextStyles.textStyle59,
                      ),
                    ],
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Interest charged", style: TextStyles.textStyle60),
                          Text("₹ 545", style: TextStyles.textStyle61),
                        ],
                      ),
                      SizedBox(
                        width: w10p * .5,
                      ),
                      const Text(
                        "₹ 12,345 ",
                        style: TextStyles.textStyle58,
                      ),
                      SizedBox(
                        width: w10p * .2,
                      ),
                      const Text(
                        "30.Aug.2022",
                        style: TextStyles.textStyle94,
                      ),
                    ],
                  )
                ]),
          ),
        ),
        children: [
          InvoiceDueDateWidget(maxWidth: maxWidth,maxHeight: maxHeight,invoiceDate:"12.Jun.2022",companyName: "Company Name",dueDate: "28.Jun.2022",companyNameDue: "Company Name",),
           const InterestCharged(amount: "12,345",interest: "545",),
          const InvoiceamtWidget(heading1:"12,345",heading2: "12.Aug.2022"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, interestPaymentDetails);
                  },
                    child: Image.asset("assets/images/phistory_viewfulldetails.png")),
              ],
            ),
          )
        ],
      );
    });
  }
}
