import 'package:flutter/material.dart';

import '../../theme/constants.dart';


class InvoiceId extends StatelessWidget {
  const InvoiceId({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Container(
          decoration: BoxDecoration(color: Colours.offWhite),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Invoice ID",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      "#4321",
                      style: TextStyles.textStyle56,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Invoice Amount",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      "₹ 12,345",
                      style: TextStyles.textStyle56,
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
