import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/constants.dart';

class InvoiceNotFound extends StatefulWidget {
  double maxHeight;
  double maxWidth;
  String notFoundMssg;
  String name;
  InvoiceNotFound(
      {required this.maxHeight,
      required this.maxWidth,
      required this.notFoundMssg,
      required this.name});
  @override
  State<StatefulWidget> createState() {
    return StateInvoiceNotFound();
  }
}

class StateInvoiceNotFound extends State<InvoiceNotFound> {
  late double maxHeight;
  late double maxWidth;
  late double h1p;
  late double h10p;
  late double w10p;
  late String notFoundMssg;
  late String name;
  @override
  void initState() {
    // TODO: implement initState
    maxHeight = widget.maxHeight;
    maxWidth = widget.maxWidth;
    h1p = maxHeight * 0.01;
    h10p = maxHeight * 0.1;
    w10p = maxWidth * 0.1;
    notFoundMssg = widget.notFoundMssg;
    name = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: h1p * 4, horizontal: w10p * .3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$name", style: TextStyles.textStyle38),
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
                              vertical: h1p * 4, horizontal: w10p * .3),
                          child: Row(children: [
                            SvgPicture.asset("assets/images/logo1.svg"),
                            SizedBox(
                              width: w10p * 0.5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "$notFoundMssg",
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
                    child: Image.asset("assets/images/onboard-image-3.png"),
                  ),
                ],
              ),
            )));
  }
}
