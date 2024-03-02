import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/drawer_widget.dart';
import '../../../widgets/payment_history_widgets/bill_details.dart';
import '../../../widgets/payment_history_widgets/invoice_due.dart';
import '../../../widgets/payment_history_widgets/invoice_id.dart';
import '../../../widgets/profile/profile_widget.dart';


class OverdueDetails extends StatefulWidget {
  const OverdueDetails({Key? key}) : super(key: key);

  @override
  State<OverdueDetails> createState() => _OverdueDetailsState();
}

class _OverdueDetailsState extends State<OverdueDetails> {
  GlobalKey<ScaffoldState> sk = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
        key: sk,
          endDrawer:  DrawerWidget(
          maxHeight: maxHeight,
          maxWidth: maxWidth,),
        backgroundColor: Colours.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: h10p * 1.7,
          flexibleSpace:ProfileWidget(pskey: sk),
        ),
        body: Column(children: [
          SizedBox(
            height: h10p * .3,
          ),
          Expanded(
              child: Container(
            width: maxWidth,
            decoration:  BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                )),
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context, landing);
                          },
                          child:
                              SvgPicture.asset("assets/images/arrowLeft.svg")),
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

                // CompanyDetailsWidget(
                //   maxHeight: maxHeight,
                //   maxWidth: maxWidth,
                //   image: "assets/images/nippon-logo.png",
                //   companyName: "Nippon Paint",
                //   creditLimit: "Credit Limit : ₹ 98,000",
                // ),
                SizedBox(height: h1p * 2),
                const InvoiceId(),

                const Text(
                  "12 days left",
                  style: TextStyles.textStyle57,
                  textAlign: TextAlign.center,
                ),

                InvoiceDueDateWidget(
                  maxWidth: maxWidth,
                  maxHeight: maxHeight,
                  invoiceDate: "12.Jun.2022",
                  companyName: "Company Name",
                  dueDate: "28.Jun.2022",
                  companyNameDue: "Company Name",
                ),

                Card(
                  elevation: .5,
                  child: Container(

                    color: Colours.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Invoice Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ 12,345",
                                    style: TextStyles.textStyle65,
                                  )
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Payabe Amount",
                                    style: TextStyles.textStyle62,
                                  ),
                                  Text(
                                    "₹ 12,845",
                                    style: TextStyles.textStyle66,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h1p * 1,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "Interest",
                                style: TextStyles.textStyle62,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                "₹ 500",
                                style: TextStyles.textStyle73,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, paynow);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 12, top: 12),
                              child: Container(
                                height: h10p * .6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colours.successPrimary,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Pay Now",
                                    style: TextStyles.textStyle46,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h1p * 2,
                ),
                BillDetailsWidget(
                    maxHeight: maxHeight,
                    maxWidth: maxWidth,
                    heading: "Bill Details"),
              ],
            ),
          )),
        ]),
      );
    });
  }
}
