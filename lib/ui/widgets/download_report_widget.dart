import 'package:flutter/material.dart';

import '../routes/router.dart';
import '../theme/constants.dart';

class DownloadReport extends StatelessWidget {
  final double maxHeight;
  final double maxWidth;
  DownloadReport({required this.maxHeight, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: h1p * 3, horizontal: w10p * .5),
          child: Container(
            height: h10p * .9,
            width: w10p * 4.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6), color: Colours.pumpkin),
            child: Center(
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, pendingInvoiceReport);
                    },
                    child: const Text(
                      "Download Report",
                      style: TextStyles.subHeading,
                    ))),
          ),
        ),
      ],
    );
  }
}
