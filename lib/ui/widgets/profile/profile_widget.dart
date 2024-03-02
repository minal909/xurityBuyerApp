import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../logic/view_models/transaction_manager.dart';
import 'package:xuriti/ui/widgets/drawer_widget.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidget({Key? key, pskey}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
        endDrawer: DrawerWidget(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        ),
        body: Consumer<TransactionManager>(builder: (context, params, child) {
          return Container(
            height: maxHeight,
            width: maxWidth,
            color: Colours.black,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 39, left: 25, right: 25),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/xuriti1.png"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Column(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 30, top: 30),
                        //       child:
                        //           Image.asset("assets/images/rewardLevel2.png"),
                        //     ),
                        //     const Padding(
                        //       padding: EdgeInsets.only(left: 29),
                        //       child: Text(
                        //         "Level 2",
                        //         style: TextStyles.textStyle86,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Opacity(
                              opacity: 0.6000000238418579,
                              child: Container(
                                // width: w10p * 3.7,
                                height: h10p * 3.5,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: h1p * 3.5,
                                    ),
                                    const Text(
                                      "Total Credit Limit / Credit Available",
                                      style: TextStyles.textStyle71,
                                    ),
                                    SizedBox(
                                      height: h1p * 0.2,
                                    ),
                                    Text(
                                      "₹ ${params.selectedCreditLimit} lacs/₹ ${params.availableCredit} lacs",
                                      style: TextStyles.textStyle22,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, homeCompanyList);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: 15, top: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 1, color: Colors.white)
                                //more than 50% of width makes circle
                                ),
                            child: Icon(
                              Icons.business_center,
                              color: Colours.tangerine,
                            ),
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      );
    });
  }
}
