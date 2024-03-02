import 'package:flutter/material.dart';

import '../../theme/constants.dart';


class InvoiceSavedAmtWidget extends StatelessWidget {
  final String heading1;
  final String heading2;
  final String heading3;
  final bool  boolValue;
  const InvoiceSavedAmtWidget({required this.heading1,required this.heading2,required this.heading3,required this.boolValue}) ;

  @override
  Widget build(BuildContext context) {
   bool isRed = boolValue;
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      "Invoice Amount",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      "₹ $heading1",
                      style: TextStyles.textStyle65,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text(
                      heading2,
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      heading3,
                      style:isRed?TextStyles.textStyle101: TextStyles.textStyle77,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
