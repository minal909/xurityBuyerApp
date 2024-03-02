import 'package:flutter/material.dart';

import '../../theme/constants.dart';


class InterestCharged extends StatelessWidget {
  final String amount;
  final String interest;

  const InterestCharged({required this.amount,required this.interest}) ;

  @override
  Widget build(BuildContext context) {
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
                      "₹ $amount",
                      style: TextStyles.textStyle65,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text(
                      "Interest Charged",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      "₹ $interest",
                      style: TextStyles.textStyle101,
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
