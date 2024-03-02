import 'package:flutter/material.dart';

import '../../theme/constants.dart';


class InvoiceamtWidget extends StatelessWidget {
  final String heading1;
  final String heading2;
  const InvoiceamtWidget({required this.heading1,required this.heading2}) ;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return
        Padding(
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
                      "Payment Amount",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      "₹ $heading1",
                      style: TextStyles.textStyle66,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    const Text(
                      "Payment Date",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      heading2,
                      style: TextStyles.textStyle66,
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
