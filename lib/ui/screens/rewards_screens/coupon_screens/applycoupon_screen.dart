import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/router.dart';
import '../../../theme/constants.dart';
import '../../../widgets/appbar/app_bar_widget.dart';

class ApplycouponScreen extends StatefulWidget {
  const ApplycouponScreen({Key? key}) : super(key: key);

  @override
  State<ApplycouponScreen> createState() => _ApplycouponScreenState();
}

class _ApplycouponScreenState extends State<ApplycouponScreen> {
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
                  flexibleSpace:  AppbarWidget()),
              // appBar: AppBar(
              //   elevation: 0,
              //   backgroundColor: Colours.black,
              //   leading: Padding(
              //     padding: const EdgeInsets.only(left: 15),
              //     child: Image.asset("assets/images/xuriti1.png"),
              //   ),
              //   actions: [
              //     Padding(
              //         padding: const EdgeInsets.all(14),
              //         child: SvgPicture.asset("assets/images/menubutton.svg")),
              //   ],
              // ),
              body: Column(children: [
                Expanded(
                    child: Container(
                        width: maxWidth,
                        // height: h10p*3,
                        decoration: const BoxDecoration(
                            color: Colours.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26),
                            )),
                        child: ListView(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 15),
                            child: Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/images/arrowLeft.svg")),
                                SizedBox(
                                  width: w10p * .3,
                                ),
                                const Text(
                                  "Company Name",
                                  style: TextStyles.textStyle41,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 13),
                            child: Row(
                              children: const [
                                Text(
                                  "Additional Offers & Benefits",
                                  style: TextStyles.textStyle78,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              elevation: 1,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: h10p * 1,
                                  width: w10p * 9.5,
                                  // color: Colours.black,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colours.offWhite,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/logo1.svg"),
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
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Card(
                              elevation: 1,
                              child: Container(

                                width: maxWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colours.offWhite,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: h1p * 3.8,
                                            width: w10p * 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colours.peach,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "XUR2OFF",
                                                style: TextStyles.textStyle80,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, apply);
                                            },
                                            child: const Text(
                                              "Apply",
                                              style: TextStyles.textStyle79,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          "2% extra savings on invoice payment\ntransactions above 2.5 lacs",
                                          style: TextStyles.textStyle44,
                                        ),
                                      ),

                                      SizedBox(
                                        height: h1p * .5,
                                      ),
                                      const Text(
                                        "Use coupon_screens code XUR2OFF & get 2% off on transactions of ₹ 2,50,000/- and above",
                                        style: TextStyles.textStyle81,
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Card(
                              elevation: 1,
                              child: Container(

                                width: maxWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colours.offWhite,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: h1p * 3.8,
                                            width: w10p * 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Colours.peach,
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "FIRSTUSER",
                                                style: TextStyles.textStyle80,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, apply);
                                            },
                                            child: const Text(
                                              "Apply",
                                              style: TextStyles.textStyle79,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          "Flat ₹ 2000 OFF on paments above ₹ 50,000/-",
                                          style: TextStyles.textStyle44,
                                        ),
                                      ),
                                      SizedBox(
                                        height: h1p * .5,
                                      ),
                                      const Text("Use coupon_screens code FIRSTUSER & get ₹ 2000 off on transactions of ₹ 50,000/- and above",
                                        style: TextStyles.textStyle81,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ])))
              ])));
    });
  }
}
