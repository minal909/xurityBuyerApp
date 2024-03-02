import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes/router.dart';
import '../../theme/constants.dart';
import '../../widgets/appbar/app_bar_widget.dart';
import '../../widgets/payment_history_widgets/bill_details.dart';

class PaynowScreen extends StatefulWidget {
  const PaynowScreen({Key? key}) : super(key: key);

  @override
  State<PaynowScreen> createState() => _PaynowScreenState();
}

class _PaynowScreenState extends State<PaynowScreen> {
  @override
  Widget build(BuildContext context) {
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
            elevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * .8,
            flexibleSpace: AppbarWidget()),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  width: maxWidth,
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 15),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/arrowLeft.svg"),
                              SizedBox(
                                width: w10p * .3,
                              ),
                              const Text(
                                "Nippon Paint",
                                style: TextStyles.textStyle41,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            height: h10p * 1,
                            width: w10p * 9.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colours.offWhite,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/logo1.svg"),
                                  SizedBox(
                                    width: w10p * .3,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: const [
                                          Text(
                                            "₹ 545",
                                            style: TextStyles.textStyle35,
                                          ),
                                          Text(
                                            " savings on this payment",
                                            style: TextStyles.textStyle34,
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "with XURITI benefits",
                                        style: TextStyles.textStyle34,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w10p * .3,
                          ),
                          const Text(
                            "Additional Offers & Benefits",
                            style: TextStyles.textStyle78,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          elevation: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, applyCoupon);
                            },
                            child: Container(
                              height: h10p * 1,
                              width: w10p * 9.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colours.offWhite,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset("assets/images/logo1.svg"),
                                    SizedBox(
                                      width: w10p * .3,
                                    ),
                                    const Text(
                                      "Apply Coupon",
                                      style: TextStyles.textStyle78,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: w10p * .3,
                          ),
                          const Text(
                            "Invoice Details",
                            style: TextStyles.textStyle78,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          elevation: 1,
                          child: Container(
                            height: h1p * 10.5,
                            width: w10p * 9.5,
                            decoration: BoxDecoration(
                              color: Colours.offWhite,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "#4321 ",
                                            style: TextStyles.textStyle6,
                                          ),
                                          Image.asset(
                                              "assets/images/arrow.png"),
                                        ],
                                      ),
                                      const Text("Nippon Paint",
                                          style: TextStyles.textStyle59)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: const [
                                          Text(
                                            "10 days left",
                                            style: TextStyles.textStyle57,
                                          ),
                                          // Image.asset("assets/images/arrow.png"),
                                        ],
                                      ),
                                      const Text("₹ 11,800",
                                          style: TextStyles.textStyle58)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 5.0),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            height: 72,
                            width: 350,
                            color: Colours.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4, top: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: w10p * .2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Invoice Date",
                                        style: TextStyles.textStyle62,
                                      ),
                                      Text(
                                        "12.Jun.2022",
                                        style: TextStyles.textStyle63,
                                      ),
                                      Text(
                                        "Nippon Paint",
                                        style: TextStyles.textStyle64,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: w10p * 2.2,
                                  ),
                                  SvgPicture.asset("assets/images/arrow.svg"),
                                  SizedBox(
                                    width: w10p * 2,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Due Date",
                                        style: TextStyles.textStyle62,
                                      ),
                                      Text(
                                        "28.Jun.2022",
                                        style: TextStyles.textStyle63,
                                      ),
                                      Text(
                                        "Nippon Paint",
                                        style: TextStyles.textStyle64,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Container(
                          height: 130,
                          width: 360,
                          color: Colours.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 6,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        //    Text("Asian Paints",style: TextStyles.textStyle34,),
                                      ],
                                    ),
                                    SizedBox(
                                      width: w10p * 5.1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: const [
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Pay Now",
                                          style: TextStyles.textStyle62,
                                        ),
                                        Text(
                                          "₹ 11,800",
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
                                      "You Save",
                                      style: TextStyles.textStyle62,
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "₹ 545",
                                      style: TextStyles.textStyle77,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      BillDetailsWidget(
                          maxWidth: maxWidth,
                          maxHeight: maxHeight,
                          heading: "Bill Details"),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 140),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                "₹ 11,800",
                                style: TextStyles.textStyle77,
                              ),
                              SizedBox(
                                width: w10p * 3.3,
                              ),
                              Container(
                                height: h10p * .5,
                                width: w10p * 4.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colours.successPrimary,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Proceed to payment",
                                    style: TextStyles.textStyle42,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ));
    });
  }
}
